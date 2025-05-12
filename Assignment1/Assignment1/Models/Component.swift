//  Component.swift
//  Assignment1
//
//  Created by Howard Barde on 3/15/25.
//

import Foundation

struct Component: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let section: SectionType
    let documentationURL: URL
    let usageExample: String
    let keyFeatures: [String]
}
