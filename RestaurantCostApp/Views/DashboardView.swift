import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var store: DataStore
    @State private var selectedRecipe: Recipe?

    private var ingredientMap: [UUID: Ingredient] {
        Dictionary(uniqueKeysWithValues: store.ingredients.map { ($0.id, $0) })
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    summarySection
                    menuEngineeringSection
                    whatIfSection
                }
                .padding()
            }
            .navigationTitle("داشبورد")
        }
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("خلاصه سود")
                .font(.headline)
            Text("میانگین سود هر سفارش بر اساس قیمت پیشنهادی محاسبه می‌شود.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            let average = store.recipes.compactMap { recipe in
                store.templates.first.map { template in
                    CostCalculator.calculate(recipe: recipe, ingredients: ingredientMap, settings: store.settings, template: template).suggestedPrice
                }
            }.reduce(0.0, +) / Double(max(store.recipes.count, 1))
            Text("میانگین قیمت پیشنهادی: \(CurrencyFormatter.rial(average))")
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var menuEngineeringSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ماتریس مهندسی منو")
                .font(.headline)
            ForEach(store.recipes) { recipe in
                let label = menuLabel(for: recipe)
                HStack {
                    Text(recipe.name)
                    Spacer()
                    Text(label)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var whatIfSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("تحلیل سناریو")
                .font(.headline)
            Picker("دستور", selection: $selectedRecipe) {
                Text("انتخاب دستور").tag(Optional<Recipe>.none)
                ForEach(store.recipes) { recipe in
                    Text(recipe.name).tag(Optional(recipe))
                }
            }
            .pickerStyle(.menu)

            if let recipe = selectedRecipe, let template = store.templates.first {
                let base = CostCalculator.calculate(recipe: recipe, ingredients: ingredientMap, settings: store.settings, template: template)
                let increasedIngredients = ingredientMap.mapValues { ingredient in
                    var updated = ingredient
                    updated.purchasePricePerUnitRial *= 1.10
                    return updated
                }
                let scenario = CostCalculator.calculate(recipe: recipe, ingredients: increasedIngredients, settings: store.settings, template: template)
                Text("افزایش ۱۰٪ قیمت مواد باعث افزایش \(CurrencyFormatter.rial(scenario.totalCostPerServing - base.totalCostPerServing)) در هر نفر می‌شود.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Text("یک دستور برای تحلیل انتخاب کنید.")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func menuLabel(for recipe: Recipe) -> String {
        let popularity = Double(recipe.preparationMinutes)
        if popularity < 70 { return "ستاره" }
        if popularity < 100 { return "معما" }
        if popularity < 130 { return "گاو شیرده" }
        return "سگ"
    }
}
