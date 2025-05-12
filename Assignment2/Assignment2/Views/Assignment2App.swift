//
//  Assignment2App.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import SwiftUI

@main
struct Assignment2App: App {
    @AppStorage("onboardingShown") var onboardingShown: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
