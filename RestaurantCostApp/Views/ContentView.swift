import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("دستورها", systemImage: "book")
                }

            IngredientsView()
                .tabItem {
                    Label("مواد", systemImage: "leaf")
                }

            DashboardView()
                .tabItem {
                    Label("داشبورد", systemImage: "chart.bar")
                }

            SettingsView()
                .tabItem {
                    Label("تنظیمات", systemImage: "gear")
                }
        }
        .tint(.orange)
    }
}
