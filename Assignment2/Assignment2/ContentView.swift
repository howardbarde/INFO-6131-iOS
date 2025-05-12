//
//  ContentView.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingShown") var onboardingShown: Bool = false

    var body: some View {
        if onboardingShown {
            TabView {
                EmployeeListView()
                    .tabItem {
                        Label("Employees", systemImage: "person.3")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        } else {
            OnboardingView()
        }
    }
}
