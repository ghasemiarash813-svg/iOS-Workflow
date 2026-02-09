import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: DataStore
    @State private var useFaceID = true
    @State private var useCloudSync = true

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("امنیت")) {
                    Toggle("قفل با Face ID / Touch ID", isOn: $useFaceID)
                    Text("حافظه محلی رمزگذاری می‌شود و داده‌ها فقط در دستگاه ذخیره می‌گردد.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section(header: Text("همگام‌سازی")) {
                    Toggle("پشتیبان‌گیری ابری", isOn: $useCloudSync)
                    Text("در صورت اتصال به اینترنت، داده‌ها با iCloud همگام می‌شوند.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section(header: Text("نرخ‌ها و هزینه‌ها")) {
                    CostField(title: "نرخ ساعتی آشپز", value: $store.settings.chefHourlyRateRial)
                    CostField(title: "اجاره ماهانه", value: $store.settings.monthlyRentRial)
                    Stepper("سفارش ماهانه: \(store.settings.monthlyOrdersEstimate)", value: $store.settings.monthlyOrdersEstimate, in: 100...20_000, step: 100)
                    PercentField(title: "درصد تخصیص اجاره", value: $store.settings.rentAllocationPercent)
                    CostField(title: "هزینه خدمات", value: $store.settings.utilitiesPerServingRial)
                    CostField(title: "استهلاک تجهیزات", value: $store.settings.equipmentDepreciationPerServingRial)
                    CostField(title: "بازاریابی", value: $store.settings.marketingPerItemRial)
                    CostField(title: "بیمه و مجوز", value: $store.settings.insurancePerItemRial)
                    CostField(title: "بسته‌بندی", value: $store.settings.packagingPerItemRial)
                    CostField(title: "ارسال", value: $store.settings.deliveryPerItemRial)
                    PercentField(title: "کارمزد پرداخت", value: $store.settings.paymentProcessingPercent)
                    PercentField(title: "حاشیه سود", value: $store.settings.desiredProfitMargin)
                    PercentField(title: "بافر حداقل", value: $store.settings.minimumBufferPercent)
                    PercentField(title: "مالیات ارزش افزوده", value: $store.settings.vatPercent)
                }

                Section {
                    Button("ذخیره تنظیمات") {
                        store.save()
                    }
                }
            }
            .navigationTitle("تنظیمات")
        }
    }
}

private struct CostField: View {
    let title: String
    @Binding var value: Double

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", value: $value, format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
        }
    }
}

private struct PercentField: View {
    let title: String
    @Binding var value: Double

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", value: $value, format: .percent)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
}
