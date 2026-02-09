import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject private var store: DataStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.ingredients) { ingredient in
                    NavigationLink(destination: IngredientDetailView(ingredient: ingredient)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ingredient.name)
                                .font(.headline)
                            Text("\(ingredient.category.localizedTitle) • \(CurrencyFormatter.rial(ingredient.purchasePricePerUnitRial))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("بانک مواد اولیه")
        }
    }
}

struct IngredientDetailView: View {
    let ingredient: Ingredient

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(ingredient.name)
                .font(.title2)
            Text("دسته‌بندی: \(ingredient.category.localizedTitle)")
            Text("تامین‌کننده: \(ingredient.supplier)")
            Text("کیفیت: \(ingredient.qualityGrade)")
            Text("ضریب تبدیل: \(ingredient.conversionRatio, specifier: "%.2f")")
            Text("ضریب ضایعات: \(ingredient.wasteFactor * 100, specifier: "%.0f")٪")
            Text("قیمت واحد: \(CurrencyFormatter.rial(ingredient.purchasePricePerUnitRial))")
            Text("معادل تومان: \(CurrencyFormatter.toman(ingredient.purchasePricePerUnitRial))")
            Divider()
            Text("تاریخچه قیمت")
                .font(.headline)
            if ingredient.priceHistory.isEmpty {
                Text("داده‌ای ثبت نشده است.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(ingredient.priceHistory) { point in
                    HStack {
                        Text(point.date.formatted(date: .abbreviated, time: .omitted))
                        Spacer()
                        Text(CurrencyFormatter.rial(point.pricePerUnitRial))
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("جزئیات ماده")
        .navigationBarTitleDisplayMode(.inline)
    }
}
