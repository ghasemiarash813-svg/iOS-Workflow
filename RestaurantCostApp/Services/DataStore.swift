import Foundation

final class DataStore: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var ingredients: [Ingredient]
    @Published var templates: [LocationPricingTemplate]
    @Published var settings: CostSettings

    private let recipesURL: URL
    private let ingredientsURL: URL
    private let templatesURL: URL
    private let settingsURL: URL

    init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        recipesURL = documents.appendingPathComponent("recipes.json")
        ingredientsURL = documents.appendingPathComponent("ingredients.json")
        templatesURL = documents.appendingPathComponent("templates.json")
        settingsURL = documents.appendingPathComponent("settings.json")

        recipes = []
        ingredients = []
        templates = []
        settings = .default

        load()
        if recipes.isEmpty || ingredients.isEmpty {
            preloadSampleData()
            save()
        }
    }

    func load() {
        recipes = loadData(from: recipesURL, fallback: [])
        ingredients = loadData(from: ingredientsURL, fallback: [])
        templates = loadData(from: templatesURL, fallback: Self.defaultTemplates)
        settings = loadData(from: settingsURL, fallback: .default)
    }

    func save() {
        saveData(recipes, to: recipesURL)
        saveData(ingredients, to: ingredientsURL)
        saveData(templates, to: templatesURL)
        saveData(settings, to: settingsURL)
    }

    private func loadData<T: Decodable>(from url: URL, fallback: T) -> T {
        guard let data = try? Data(contentsOf: url) else { return fallback }
        return (try? JSONDecoder().decode(T.self, from: data)) ?? fallback
    }

    private func saveData<T: Encodable>(_ value: T, to url: URL) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        try? data.write(to: url, options: .atomic)
    }

    private func preloadSampleData() {
        ingredients = SampleData.ingredients
        recipes = SampleData.recipes
        templates = Self.defaultTemplates
    }

    static let defaultTemplates: [LocationPricingTemplate] = [
        LocationPricingTemplate(
            title: "تهران - منطقه ۱",
            city: .tehran,
            district: "منطقه ۱",
            venueType: .standalone,
            rentMultiplier: 1.4,
            seasonalMultiplier: 1.1
        ),
        LocationPricingTemplate(
            title: "تهران - منطقه ۱۰",
            city: .tehran,
            district: "منطقه ۱۰",
            venueType: .foodCourt,
            rentMultiplier: 1.0,
            seasonalMultiplier: 1.0
        ),
        LocationPricingTemplate(
            title: "اصفهان - مرکز شهر",
            city: .isfahan,
            district: "مرکز شهر",
            venueType: .standalone,
            rentMultiplier: 0.9,
            seasonalMultiplier: 1.0
        )
    ]
}
