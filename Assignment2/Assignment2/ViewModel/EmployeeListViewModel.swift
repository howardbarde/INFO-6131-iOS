//
//  EmployeeViewModel.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import Foundation
import Combine

class EmployeeListViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var filteredEmployees: [Employee] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    init() {
        $searchText
            .sink { [weak self] query in
                self?.filterEmployees(with: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchEmployees() {
        if let cachedEmployees = loadCachedEmployees() {
            self.employees = cachedEmployees
            self.filteredEmployees = cachedEmployees
            return
        }
        isLoading = true
        errorMessage = nil
        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: EmployeeListResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { response in
                self.employees = response.employees
                self.filteredEmployees = response.employees
                self.saveEmployeesToCache(response.employees)
            })
            .store(in: &cancellables)
    }
    
    private func filterEmployees(with query: String) {
        if query.isEmpty {
            filteredEmployees = employees
        } else {
            filteredEmployees = employees.filter { employee in
                employee.fullName.lowercased().contains(query.lowercased())
            }
        }
    }

    private func saveEmployeesToCache(_ employees: [Employee]) {
        if let encoded = try? JSONEncoder().encode(employees) {
            UserDefaults.standard.set(encoded, forKey: "employeesCache")
        }
    }

    func loadCachedEmployees() -> [Employee]? {
        guard let data = UserDefaults.standard.data(forKey: "employeesCache"),
              let employees = try? JSONDecoder().decode([Employee].self, from: data) else {
                  return nil
              }
        return employees
    }
}

struct EmployeeListResponse: Codable {
    let employees: [Employee]
}
