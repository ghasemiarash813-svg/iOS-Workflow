import SwiftUI

struct RecipesView: View {
    @EnvironmentObject private var store: DataStore
    @State private var selectedTemplateIndex = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("الگوی قیمت", selection: $selectedTemplateIndex) {
                    ForEach(store.templates.indices, id: \.self) { index in
                        Text(store.templates[index].title).tag(index)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)

                List {
                    ForEach(store.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe, template: store.templates[safe: selectedTemplateIndex] ?? store.templates.first)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text("\(recipe.category.localizedTitle) • \(recipe.servingSize) نفر")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("مدیریت دستورها")
        }
    }
}

struct RecipeDetailView: View {
    @EnvironmentObject private var store: DataStore
    let recipe: Recipe
    let template: LocationPricingTemplate?
    @State private var scaledServing: Int

    init(recipe: Recipe, template: LocationPricingTemplate?) {
        self.recipe = recipe
        self.template = template
        _scaledServing = State(initialValue: recipe.servingSize)
    }

    private var ingredientMap: [UUID: Ingredient] {
        Dictionary(uniqueKeysWithValues: store.ingredients.map { ($0.id, $0) })
    }

    private var scaledRecipe: Recipe {
        CostCalculator.scaleRecipe(recipe, to: scaledServing)
    }

    private var costBreakdown: CostBreakdown? {
        guard let template else { return nil }
        return CostCalculator.calculate(recipe: scaledRecipe, ingredients: ingredientMap, settings: store.settings, template: template)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                ingredientSection
                stepsSection
                costSection
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("ذخیره") {
                    store.save()
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(recipe.category.localizedTitle) • \(recipe.difficulty.localizedTitle)")
                .foregroundStyle(.secondary)
            Text("زمان آماده‌سازی: \(recipe.preparationMinutes) دقیقه")
                .font(.subheadline)
            Stepper("تعداد نفرات: \(scaledServing)", value: $scaledServing, in: 1...200)
                .padding(.top, 8)
        }
    }

    private var ingredientSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("مواد اولیه")
                .font(.headline)
            ForEach(scaledRecipe.ingredients) { item in
                let ingredient = ingredientMap[item.ingredientID]
                HStack {
                    Text(ingredient?.name ?? "-")
                    Spacer()
                    Text("\(item.quantity, specifier: "%.2f") \(item.unit.localizedTitle)")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("مراحل پخت")
                .font(.headline)
            ForEach(recipe.steps.sorted { $0.order < $1.order }) { step in
                Text("\(step.order). \(step.instruction)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var costSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("محاسبات هزینه")
                .font(.headline)

            if let costBreakdown {
                CostRow(title: "هزینه مستقیم", value: costBreakdown.directCostPerServing)
                CostRow(title: "سربار", value: costBreakdown.overheadPerServing)
                CostRow(title: "هزینه متغیر", value: costBreakdown.variablePerServing)
                Divider()
                CostRow(title: "هزینه کل هر نفر", value: costBreakdown.totalCostPerServing)
                CostRow(title: "قیمت پیشنهادی", value: costBreakdown.suggestedPrice)
                CostRow(title: "حداقل قیمت", value: costBreakdown.minimumPrice)
                CostRow(title: "دامنه رقابتی", value: costBreakdown.competitiveRange.lowerBound, suffix: " تا \(CurrencyFormatter.rial(costBreakdown.competitiveRange.upperBound))")
                CostRow(title: "مالیات ارزش افزوده", value: costBreakdown.vatAmount)
                Text("تمام فرمول‌ها بر اساس نرخ‌های فعلی و ضریب مکان اجرا شده‌اند.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            } else {
                Text("الگوی قیمت انتخاب نشده است.")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct CostRow: View {
    let title: String
    let value: Double
    var suffix: String? = nil

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(CurrencyFormatter.rial(value))\(suffix ?? "")")
                .foregroundStyle(.secondary)
        }
        .font(.subheadline)
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
