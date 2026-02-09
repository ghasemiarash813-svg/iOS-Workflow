import Foundation

struct CostSettings: Codable, Hashable {
    var chefHourlyRateRial: Double
    var monthlyRentRial: Double
    var monthlyOrdersEstimate: Int
    var rentAllocationPercent: Double
    var utilitiesPerServingRial: Double
    var equipmentDepreciationPerServingRial: Double
    var marketingPerItemRial: Double
    var insurancePerItemRial: Double
    var packagingPerItemRial: Double
    var deliveryPerItemRial: Double
    var paymentProcessingPercent: Double
    var desiredProfitMargin: Double
    var minimumBufferPercent: Double
    var vatPercent: Double

    static let `default` = CostSettings(
        chefHourlyRateRial: 2_500_000,
        monthlyRentRial: 800_000_000,
        monthlyOrdersEstimate: 4_000,
        rentAllocationPercent: 0.25,
        utilitiesPerServingRial: 40_000,
        equipmentDepreciationPerServingRial: 30_000,
        marketingPerItemRial: 20_000,
        insurancePerItemRial: 10_000,
        packagingPerItemRial: 15_000,
        deliveryPerItemRial: 25_000,
        paymentProcessingPercent: 0.015,
        desiredProfitMargin: 0.35,
        minimumBufferPercent: 0.05,
        vatPercent: 0.09
    )
}

struct LocationPricingTemplate: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var city: City
    var district: String?
    var venueType: VenueType
    var rentMultiplier: Double
    var seasonalMultiplier: Double

    init(
        id: UUID = UUID(),
        title: String,
        city: City,
        district: String? = nil,
        venueType: VenueType,
        rentMultiplier: Double,
        seasonalMultiplier: Double
    ) {
        self.id = id
        self.title = title
        self.city = city
        self.district = district
        self.venueType = venueType
        self.rentMultiplier = rentMultiplier
        self.seasonalMultiplier = seasonalMultiplier
    }
}

enum City: String, Codable, CaseIterable {
    case tehran
    case isfahan
    case shiraz
    case mashhad
    case tabriz
    case other

    var localizedTitle: String {
        switch self {
        case .tehran: return "تهران"
        case .isfahan: return "اصفهان"
        case .shiraz: return "شیراز"
        case .mashhad: return "مشهد"
        case .tabriz: return "تبریز"
        case .other: return "سایر"
        }
    }
}

enum VenueType: String, Codable, CaseIterable {
    case foodCourt
    case standalone
    case cafe

    var localizedTitle: String {
        switch self {
        case .foodCourt: return "فودکورت"
        case .standalone: return "رستوران مستقل"
        case .cafe: return "کافه"
        }
    }
}
