//
//  EmployeeListView.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
import SwiftUI

struct EmployeeListView: View {
    @StateObject var viewModel = EmployeeListViewModel()
    @AppStorage("onboardingShown") var onboardingShown: Bool = false
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.filteredEmployees.isEmpty {
                    Text("No employees found")
                        .padding()
                } else {
                    List(viewModel.filteredEmployees) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                            HStack {
                                AsyncImage(url: URL(string: employee.photoUrlSmall)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 63, height: 63)
                                        .clipShape(Rectangle())
                                        .cornerRadius(6)
                                } placeholder: {
                                    Rectangle().fill(Color.gray)
                                        .frame(width: 63, height: 63)
                                        .cornerRadius(6)
                                }
                                VStack(alignment: .leading) {
                                    Text(employee.fullName)
                                        .font(.headline)
                                        .lineLimit(1)
                                    Text(employee.team)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                                .padding(.leading, 6)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        if let cachedEmployees = viewModel.loadCachedEmployees() {
                            viewModel.employees = cachedEmployees
                            viewModel.filteredEmployees = cachedEmployees
                        }
                    }
                }
            }
            .padding(.top, 1)
            .navigationTitle("Employees")
            .searchable(text: $viewModel.searchText)
            .onAppear {
                if !onboardingShown {
                    onboardingShown = true
                } else {
                    viewModel.fetchEmployees()
                }
            }
            .onChange(of: onboardingShown) { _ in
                viewModel.fetchEmployees()
            }
        }
    }
}
