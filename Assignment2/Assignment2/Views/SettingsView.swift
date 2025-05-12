//
//  SettingsView.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.blue.opacity(0.8))
                    .padding(.top, 40)
                VStack(spacing: 8) {
                    Text("Assignment 2")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Howard Barde • 1016999")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}
