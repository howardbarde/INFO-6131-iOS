//
//  OnboardingView.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingShown") var onboardingShown: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 60/255, green: 173/255, blue: 225/255),
                    Color(red: 33/255, green: 121/255, blue: 184/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Employee List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .shadow(radius: 8)
                    Image("employees2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                Spacer()
                Text("This application shows the list of employees who are fetched from network. You can search employees by name and view their details by pressing them.")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                Button(action: {
                    onboardingShown = true
                }) {
                    Text("Continue")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color(red: 33/255, green: 121/255, blue: 184/255))
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
            }
        }
    }
}
