import Foundation

struct CostBreakdown: Hashable {
    var directCostPerServing: Double
    var overheadPerServing: Double
    var variablePerServing: Double
    var totalCostPerServing: Double
    var suggestedPrice: Double
    var minimumPrice: Double
    var competitiveRange: ClosedRange<Double>
    var vatAmount: Double
}

struct CostCalculator {
    static func calculate(
        recipe: Recipe,
        ingredients: [UUID: Ingredient],
        settings: CostSettings,
        template: LocationPricingTemplate
    ) -> CostBreakdown {
        let scaledSettings = apply(template: template, to: settings)
        let directCost = rawMaterialCost(recipe: recipe, ingredients: ingredients) + laborCost(recipe: recipe, settings: scaledSettings)
        let overhead = overheadCost(settings: scaledSettings)
        let variable = variableCost(settings: scaledSettings)
        let total = directCost + overhead + variable
        let suggested = total * (1 + scaledSettings.desiredProfitMargin)
        let minimum = total * (1 + scaledSettings.minimumBufferPercent)
        let competitiveLow = total * 1.05
        let competitiveHigh = total * 1.25
        let vatAmount = total * scaledSettings.vatPercent

        return CostBreakdown(
            directCostPerServing: directCost,
            overheadPerServing: overhead,
            variablePerServing: variable,
            totalCostPerServing: total,
            suggestedPrice: suggested,
            minimumPrice: minimum,
            competitiveRange: competitiveLow...competitiveHigh,
            vatAmount: vatAmount
        )
    }

    static func scaleRecipe(_ recipe: Recipe, to servings: Int) -> Recipe {
        guard servings > 0, recipe.servingSize > 0 else { return recipe }
        let multiplier = Double(servings) / Double(recipe.servingSize)
        let scaledIngredients = recipe.ingredients.map { ingredient in
            RecipeIngredient(
                id: ingredient.id,
                ingredientID: ingredient.ingredientID,
                quantity: ingredient.quantity * multiplier,
                unit: ingredient.unit
            )
        }
        return Recipe(
            id: recipe.id,
            name: recipe.name,
            category: recipe.category,
            servingSize: servings,
            preparationMinutes: recipe.preparationMinutes,
            difficulty: recipe.difficulty,
            ingredients: scaledIngredients,
            steps: recipe.steps,
            photos: recipe.photos
        )
    }

    static func rawMaterialCost(recipe: Recipe, ingredients: [UUID: Ingredient]) -> Double {
        let total = recipe.ingredients.reduce(0.0) { partial, item in
            guard let ingredient = ingredients[item.ingredientID] else { return partial }
            let wasteMultiplier = 1 + ingredient.wasteFactor
            let conversionMultiplier = ingredient.conversionRatio
            let unitCost = ingredient.purchasePricePerUnitRial
            let itemCost = item.quantity * unitCost * wasteMultiplier / max(conversionMultiplier, 0.01)
            return partial + itemCost
        }
        return total / Double(max(recipe.servingSize, 1))
    }

    static func laborCost(recipe: Recipe, settings: CostSettings) -> Double {
        let hourlyRate = settings.chefHourlyRateRial
        let hours = Double(recipe.preparationMinutes) / 60.0
        let totalLabor = hourlyRate * hours
        return totalLabor / Double(max(recipe.servingSize, 1))
    }

    static func overheadCost(settings: CostSettings) -> Double {
        let rentAllocation = settings.monthlyRentRial / Double(max(settings.monthlyOrdersEstimate, 1)) * settings.rentAllocationPercent
        return rentAllocation + settings.utilitiesPerServingRial + settings.equipmentDepreciationPerServingRial + settings.marketingPerItemRial + settings.insurancePerItemRial
    }

    static func variableCost(settings: CostSettings) -> Double {
        let payment = (settings.packagingPerItemRial + settings.deliveryPerItemRial) * settings.paymentProcessingPercent
        return settings.packagingPerItemRial + settings.deliveryPerItemRial + payment
    }

    static func apply(template: LocationPricingTemplate, to settings: CostSettings) -> CostSettings {
        var updated = settings
        updated.monthlyRentRial = settings.monthlyRentRial * template.rentMultiplier
        updated.utilitiesPerServingRial = settings.utilitiesPerServingRial * template.seasonalMultiplier
        return updated
    }
}
