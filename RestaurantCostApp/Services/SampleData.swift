import Foundation

enum SampleData {
    static let ingredients: [Ingredient] = [
        Ingredient(name: "برنج", category: .grains, purchasePricePerUnitRial: 1_200_000, unit: .kilogram, supplier: "بازار تجریش", qualityGrade: "A", conversionRatio: 1.0, wasteFactor: 0.02),
        Ingredient(name: "گوشت گوسفندی", category: .protein, purchasePricePerUnitRial: 4_500_000, unit: .kilogram, supplier: "بازار بهمن", qualityGrade: "A", conversionRatio: 0.85, wasteFactor: 0.08),
        Ingredient(name: "مرغ", category: .protein, purchasePricePerUnitRial: 1_900_000, unit: .kilogram, supplier: "مرغداری شمال", qualityGrade: "A", conversionRatio: 0.8, wasteFactor: 0.1),
        Ingredient(name: "زعفران", category: .spices, purchasePricePerUnitRial: 25_000_000, unit: .gram, supplier: "تجریش", qualityGrade: "Premium", conversionRatio: 1.0, wasteFactor: 0.0),
        Ingredient(name: "گوجه فرنگی", category: .vegetables, purchasePricePerUnitRial: 350_000, unit: .kilogram, supplier: "بازار مرکزی", qualityGrade: "B", conversionRatio: 0.9, wasteFactor: 0.05),
        Ingredient(name: "پیاز", category: .vegetables, purchasePricePerUnitRial: 220_000, unit: .kilogram, supplier: "بازار مرکزی", qualityGrade: "A", conversionRatio: 0.92, wasteFactor: 0.04),
        Ingredient(name: "روغن مایع", category: .oils, purchasePricePerUnitRial: 650_000, unit: .liter, supplier: "پخش روغن", qualityGrade: "A", conversionRatio: 1.0, wasteFactor: 0.02),
        Ingredient(name: "ماست", category: .dairy, purchasePricePerUnitRial: 480_000, unit: .kilogram, supplier: "دامداری مهر", qualityGrade: "A", conversionRatio: 1.0, wasteFactor: 0.01),
        Ingredient(name: "سیب زمینی", category: .vegetables, purchasePricePerUnitRial: 280_000, unit: .kilogram, supplier: "بازار مرکزی", qualityGrade: "A", conversionRatio: 0.9, wasteFactor: 0.08),
        Ingredient(name: "نان لواش", category: .grains, purchasePricePerUnitRial: 70_000, unit: .piece, supplier: "نانوایی محلی", qualityGrade: "A", conversionRatio: 1.0, wasteFactor: 0.0)
    ]

    static let recipes: [Recipe] = {
        let ingredientMap = Dictionary(uniqueKeysWithValues: ingredients.map { ($0.id, $0) })
        let riceID = ingredientMap.values.first { $0.name == "برنج" }?.id ?? UUID()
        let lambID = ingredientMap.values.first { $0.name == "گوشت گوسفندی" }?.id ?? UUID()
        let chickenID = ingredientMap.values.first { $0.name == "مرغ" }?.id ?? UUID()
        let saffronID = ingredientMap.values.first { $0.name == "زعفران" }?.id ?? UUID()
        let tomatoID = ingredientMap.values.first { $0.name == "گوجه فرنگی" }?.id ?? UUID()
        let onionID = ingredientMap.values.first { $0.name == "پیاز" }?.id ?? UUID()
        let oilID = ingredientMap.values.first { $0.name == "روغن مایع" }?.id ?? UUID()
        let yogurtID = ingredientMap.values.first { $0.name == "ماست" }?.id ?? UUID()
        let potatoID = ingredientMap.values.first { $0.name == "سیب زمینی" }?.id ?? UUID()
        let breadID = ingredientMap.values.first { $0.name == "نان لواش" }?.id ?? UUID()

        return [
            Recipe(
                name: "چلوکباب",
                category: .iranian,
                servingSize: 4,
                preparationMinutes: 90,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: riceID, quantity: 1.0, unit: .kilogram),
                    RecipeIngredient(ingredientID: lambID, quantity: 1.2, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.3, unit: .kilogram),
                    RecipeIngredient(ingredientID: saffronID, quantity: 2.0, unit: .gram)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "برنج را آبکش کنید و دم بگذارید."),
                    RecipeStep(order: 2, instruction: "گوشت را مزه‌دار کرده و کباب بزنید."),
                    RecipeStep(order: 3, instruction: "کباب‌ها را گریل کنید و سرو کنید.")
                ]
            ),
            Recipe(
                name: "زرشک پلو با مرغ",
                category: .iranian,
                servingSize: 5,
                preparationMinutes: 110,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: riceID, quantity: 1.2, unit: .kilogram),
                    RecipeIngredient(ingredientID: chickenID, quantity: 1.5, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.25, unit: .kilogram),
                    RecipeIngredient(ingredientID: saffronID, quantity: 1.5, unit: .gram)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "مرغ را با پیاز تفت دهید و بپزید."),
                    RecipeStep(order: 2, instruction: "برنج را آماده کنید و زرشک را تفت دهید."),
                    RecipeStep(order: 3, instruction: "مرغ را سرو کنید و زعفران اضافه کنید.")
                ]
            ),
            Recipe(
                name: "قرمه سبزی",
                category: .iranian,
                servingSize: 6,
                preparationMinutes: 150,
                difficulty: .hard,
                ingredients: [
                    RecipeIngredient(ingredientID: lambID, quantity: 0.9, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.3, unit: .kilogram),
                    RecipeIngredient(ingredientID: oilID, quantity: 0.2, unit: .liter)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "سبزی را سرخ کنید."),
                    RecipeStep(order: 2, instruction: "گوشت را با پیاز تفت دهید."),
                    RecipeStep(order: 3, instruction: "خورش را آرام بپزید.")
                ]
            ),
            Recipe(
                name: "جوجه کباب",
                category: .fastFood,
                servingSize: 4,
                preparationMinutes: 60,
                difficulty: .easy,
                ingredients: [
                    RecipeIngredient(ingredientID: chickenID, quantity: 1.0, unit: .kilogram),
                    RecipeIngredient(ingredientID: yogurtID, quantity: 0.3, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.2, unit: .kilogram)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "مرغ را مرینیت کنید."),
                    RecipeStep(order: 2, instruction: "مرغ‌ها را سیخ کنید."),
                    RecipeStep(order: 3, instruction: "جوجه‌ها را گریل کنید.")
                ]
            ),
            Recipe(
                name: "ته چین",
                category: .iranian,
                servingSize: 6,
                preparationMinutes: 120,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: riceID, quantity: 1.1, unit: .kilogram),
                    RecipeIngredient(ingredientID: chickenID, quantity: 1.3, unit: .kilogram),
                    RecipeIngredient(ingredientID: yogurtID, quantity: 0.4, unit: .kilogram),
                    RecipeIngredient(ingredientID: saffronID, quantity: 1.0, unit: .gram)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "مرغ را بپزید و ریش‌ریش کنید."),
                    RecipeStep(order: 2, instruction: "مواد ته چین را ترکیب کنید."),
                    RecipeStep(order: 3, instruction: "ته چین را دم بگذارید.")
                ]
            ),
            Recipe(
                name: "آش رشته",
                category: .iranian,
                servingSize: 8,
                preparationMinutes: 140,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: onionID, quantity: 0.5, unit: .kilogram),
                    RecipeIngredient(ingredientID: oilID, quantity: 0.15, unit: .liter)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "حبوبات را بپزید."),
                    RecipeStep(order: 2, instruction: "سبزی و رشته را اضافه کنید."),
                    RecipeStep(order: 3, instruction: "آش را جا بیندازید.")
                ]
            ),
            Recipe(
                name: "کوفته تبریزی",
                category: .iranian,
                servingSize: 6,
                preparationMinutes: 160,
                difficulty: .hard,
                ingredients: [
                    RecipeIngredient(ingredientID: lambID, quantity: 0.8, unit: .kilogram),
                    RecipeIngredient(ingredientID: riceID, quantity: 0.4, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.3, unit: .kilogram)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "مواد کوفته را مخلوط کنید."),
                    RecipeStep(order: 2, instruction: "کوفته‌ها را شکل دهید."),
                    RecipeStep(order: 3, instruction: "کوفته‌ها را بپزید.")
                ]
            ),
            Recipe(
                name: "میرزا قاسمی",
                category: .iranian,
                servingSize: 4,
                preparationMinutes: 50,
                difficulty: .easy,
                ingredients: [
                    RecipeIngredient(ingredientID: tomatoID, quantity: 0.6, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.2, unit: .kilogram),
                    RecipeIngredient(ingredientID: oilID, quantity: 0.1, unit: .liter)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "بادمجان‌ها را کبابی کنید."),
                    RecipeStep(order: 2, instruction: "مواد را تفت دهید."),
                    RecipeStep(order: 3, instruction: "نمک و ادویه اضافه کنید.")
                ]
            ),
            Recipe(
                name: "عدس پلو",
                category: .iranian,
                servingSize: 5,
                preparationMinutes: 90,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: riceID, quantity: 1.0, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.2, unit: .kilogram),
                    RecipeIngredient(ingredientID: oilID, quantity: 0.15, unit: .liter)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "عدس را نیم‌پز کنید."),
                    RecipeStep(order: 2, instruction: "برنج و عدس را دم بگذارید."),
                    RecipeStep(order: 3, instruction: "پیاز داغ را اضافه کنید.")
                ]
            ),
            Recipe(
                name: "کباب کوبیده",
                category: .iranian,
                servingSize: 4,
                preparationMinutes: 70,
                difficulty: .medium,
                ingredients: [
                    RecipeIngredient(ingredientID: lambID, quantity: 1.0, unit: .kilogram),
                    RecipeIngredient(ingredientID: onionID, quantity: 0.3, unit: .kilogram),
                    RecipeIngredient(ingredientID: breadID, quantity: 4.0, unit: .piece)
                ],
                steps: [
                    RecipeStep(order: 1, instruction: "گوشت و پیاز را مخلوط کنید."),
                    RecipeStep(order: 2, instruction: "کوبیده‌ها را به سیخ بزنید."),
                    RecipeStep(order: 3, instruction: "کباب‌ها را گریل کنید.")
                ]
            )
        ]
    }()
}
