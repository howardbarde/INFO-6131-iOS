//
//  EmployeeDetailView.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import SwiftUI

struct EmployeeDetailView: View {
    let employee: Employee
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: employee.photoUrlLarge)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 200)
                        ProgressView()
                    }
                }
                Text(employee.fullName)
                    .font(.title)
                    .fontWeight(.bold)
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        Text(employee.phoneNumber)
                    }
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.green)
                        Text(employee.emailAddress)
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                Divider()
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Team:")
                            .fontWeight(.semibold)
                        Text(employee.team)
                    }
                    HStack {
                        Text("Employee Type:")
                            .fontWeight(.semibold)
                        Text(formattedEmployeeType(employeeType: employee.employeeType))
                    }
                }
                .font(.subheadline)
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Biography")
                        .font(.headline)
                    Text(employee.biography)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.top, 4)
            }
            .padding()
        }
        .navigationTitle("Employee Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    func formattedEmployeeType(employeeType: String) -> String {
        switch employeeType {
        case "FULL_TIME": return "Full time"
        case "PART_TIME": return "Part time"
        case "CONTRACTOR": return "Contractor"
        default: return "Unknown"
        }
    }
}
