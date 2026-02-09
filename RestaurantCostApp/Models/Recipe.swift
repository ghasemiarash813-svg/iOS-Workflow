import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var category: RecipeCategory
    var servingSize: Int
    var preparationMinutes: Int
    var difficulty: Difficulty
    var ingredients: [RecipeIngredient]
    var steps: [RecipeStep]
    var photos: [PhotoReference]

    init(
        id: UUID = UUID(),
        name: String,
        category: RecipeCategory,
        servingSize: Int,
        preparationMinutes: Int,
        difficulty: Difficulty,
        ingredients: [RecipeIngredient],
        steps: [RecipeStep],
        photos: [PhotoReference] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.servingSize = servingSize
        self.preparationMinutes = preparationMinutes
        self.difficulty = difficulty
        self.ingredients = ingredients
        self.steps = steps
        self.photos = photos
    }
}

enum RecipeCategory: String, Codable, CaseIterable {
    case iranian
    case italian
    case seafood
    case fastFood
    case cafe
    case other

    var localizedTitle: String {
        switch self {
        case .iranian: return "ایرانی"
        case .italian: return "ایتالیایی"
        case .seafood: return "دریایی"
        case .fastFood: return "فست فود"
        case .cafe: return "کافه"
        case .other: return "سایر"
        }
    }
}

enum Difficulty: String, Codable, CaseIterable {
    case easy
    case medium
    case hard

    var localizedTitle: String {
        switch self {
        case .easy: return "آسان"
        case .medium: return "متوسط"
        case .hard: return "سخت"
        }
    }
}

struct RecipeIngredient: Identifiable, Codable, Hashable {
    let id: UUID
    var ingredientID: UUID
    var quantity: Double
    var unit: Unit

    init(id: UUID = UUID(), ingredientID: UUID, quantity: Double, unit: Unit) {
        self.id = id
        self.ingredientID = ingredientID
        self.quantity = quantity
        self.unit = unit
    }
}

struct RecipeStep: Identifiable, Codable, Hashable {
    let id: UUID
    var order: Int
    var instruction: String

    init(id: UUID = UUID(), order: Int, instruction: String) {
        self.id = id
        self.order = order
        self.instruction = instruction
    }
}

struct PhotoReference: Identifiable, Codable, Hashable {
    let id: UUID
    var fileName: String
    var caption: String

    init(id: UUID = UUID(), fileName: String, caption: String) {
        self.id = id
        self.fileName = fileName
        self.caption = caption
    }
}
