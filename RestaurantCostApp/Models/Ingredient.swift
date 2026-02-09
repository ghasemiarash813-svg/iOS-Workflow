import Foundation

struct Ingredient: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var category: IngredientCategory
    var purchasePricePerUnitRial: Double
    var unit: Unit
    var supplier: String
    var qualityGrade: String
    var conversionRatio: Double
    var wasteFactor: Double
    var priceHistory: [PricePoint]

    init(
        id: UUID = UUID(),
        name: String,
        category: IngredientCategory,
        purchasePricePerUnitRial: Double,
        unit: Unit,
        supplier: String,
        qualityGrade: String,
        conversionRatio: Double,
        wasteFactor: Double,
        priceHistory: [PricePoint] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.purchasePricePerUnitRial = purchasePricePerUnitRial
        self.unit = unit
        self.supplier = supplier
        self.qualityGrade = qualityGrade
        self.conversionRatio = conversionRatio
        self.wasteFactor = wasteFactor
        self.priceHistory = priceHistory
    }
}

enum IngredientCategory: String, Codable, CaseIterable {
    case grains
    case protein
    case vegetables
    case spices
    case dairy
    case oils
    case other

    var localizedTitle: String {
        switch self {
        case .grains: return "غلات"
        case .protein: return "پروتئین"
        case .vegetables: return "سبزیجات"
        case .spices: return "ادویه"
        case .dairy: return "لبنیات"
        case .oils: return "روغن‌ها"
        case .other: return "سایر"
        }
    }
}

enum Unit: String, Codable, CaseIterable {
    case kilogram
    case gram
    case liter
    case milliliter
    case piece

    var localizedTitle: String {
        switch self {
        case .kilogram: return "کیلوگرم"
        case .gram: return "گرم"
        case .liter: return "لیتر"
        case .milliliter: return "میلی‌لیتر"
        case .piece: return "عدد"
        }
    }
}

struct PricePoint: Identifiable, Codable, Hashable {
    let id: UUID
    var date: Date
    var pricePerUnitRial: Double

    init(id: UUID = UUID(), date: Date, pricePerUnitRial: Double) {
        self.id = id
        self.date = date
        self.pricePerUnitRial = pricePerUnitRial
    }
}
