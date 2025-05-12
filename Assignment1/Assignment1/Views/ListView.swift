//  ListView.swift
//  Assignment1
//
//  Created by Howard Barde on 3/15/25.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ComponentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(SectionType.allCases, id: \.self) { section in
                    Section(header: Text(section.rawValue)) {
                        ForEach(viewModel.filteredComponents.filter { $0.section == section }) { component in
                            NavigationLink(destination: DetailView(component: component)) {
                                HStack {
                                    Image(systemName: component.iconName)
                                    Text(component.name)
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery)
            .navigationTitle("Components")
        }
    }
}

