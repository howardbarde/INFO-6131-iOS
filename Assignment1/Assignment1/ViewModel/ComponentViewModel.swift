// ComponentViewModel.swift
// Assignment1
//
// Created by Howard Barde on 3/15/25.
//

import SwiftUI

class ComponentViewModel: ObservableObject {
    @Published var components: [Component] = []
    @Published var searchQuery: String = ""

    init() {
        loadComponents()
    }
    
    private func loadComponents() {
        components = [
            // Text Input/Output
            Component(name: "Text", iconName: "textformat", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/text")!, usageExample: "Text(\"Hello, World!\")", keyFeatures: ["Displays static text", "Supports multiline text"]),
            Component(name: "Label", iconName: "text.alignleft", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/label")!, usageExample: "Label(\"Username\", systemImage: \"person.circle\")", keyFeatures: ["Displays text with an optional icon", "Supports different style customizations"]),
            Component(name: "TextField", iconName: "pencil", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/textfield")!, usageExample: "TextField(\"Enter your name\", text: $name)", keyFeatures: ["User input for single-line text", "Supports keyboard types"]),
            Component(name: "SecureField", iconName: "lock.shield", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/securefield")!, usageExample: "SecureField(\"Enter your password\", text: $password)", keyFeatures: ["Hides input text for sensitive data", "Supports secure text entry"]),
            Component(name: "TextArea", iconName: "square.and.pencil", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/textarea")!, usageExample: "TextArea(\"Enter your comments\", text: $comments)", keyFeatures: ["Allows multiple lines of text input", "Flexible sizing and styling"]),
            Component(name: "Image", iconName: "photo", section: .textInputOutput, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/image")!, usageExample: "Image(systemName: \"star.fill\")", keyFeatures: ["Displays static images", "Supports image assets and system images"]),

            // Controls
            Component(name: "Button", iconName: "capsule", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/button")!, usageExample: "Button(\"Click Me\", action: { print(\"Button clicked\") })", keyFeatures: ["Triggers actions when tapped", "Supports custom styling"]),
            Component(name: "Menu", iconName: "ellipsis.circle", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/menu")!, usageExample: "Menu(\"Select Option\", content: { Text(\"Option 1\").onTapGesture { print(\"Option 1 selected\") } })", keyFeatures: ["Displays a list of options", "Supports custom actions"]),
            Component(name: "Link", iconName: "link", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/link")!, usageExample: "Link(\"Visit Apple\", destination: URL(string: \"https://www.apple.com\")!)", keyFeatures: ["Navigates to a URL", "Supports opening in Safari"]),
            Component(name: "Slider", iconName: "slider.horizontal.3", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/slider")!, usageExample: "Slider(value: $value, in: 0...100)", keyFeatures: ["Allows selection of continuous values", "Supports custom ranges"]),
            Component(name: "Stepper", iconName: "plusminus", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/stepper")!, usageExample: "Stepper(value: $value, in: 0...10, step: 1)", keyFeatures: ["Increments or decrements a value", "Supports custom ranges and steps"]),
            Component(name: "Toggle", iconName: "switch.2", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/toggle")!, usageExample: "Toggle(\"Enable feature\", isOn: $isEnabled)", keyFeatures: ["Switches between two states", "Supports custom labels"]),
            Component(name: "Picker", iconName: "arrowtriangle.right.circle.fill", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/picker")!, usageExample: "Picker(\"Select a color\", selection: $selectedColor) { Text(\"Red\").tag(Color.red) Text(\"Blue\").tag(Color.blue) }", keyFeatures: ["Allows item selection from a list", "Supports custom tags for each option"]),
            Component(name: "DatePicker", iconName: "calendar", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/datepicker")!, usageExample: "DatePicker(\"Select a date\", selection: $selectedDate)", keyFeatures: ["Allows date and time selection", "Supports customizable date ranges"]),
            Component(name: "ColorPicker", iconName: "paintpalette", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/colorpicker")!, usageExample: "ColorPicker(\"Pick a color\", selection: $selectedColor)", keyFeatures: ["Allows users to choose a color", "Supports custom color spaces"]),
            Component(name: "ProgressView", iconName: "arrow.down.circle.fill", section: .controls, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/progressview")!, usageExample: "ProgressView(value: $progress, total: 100)", keyFeatures: ["Indicates progress of a task", "Supports custom styling"]),

            // Container Views
            Component(name: "HStack", iconName: "h.square", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/hstack")!, usageExample: "HStack { Text(\"Left\"); Text(\"Center\"); Text(\"Right\") }", keyFeatures: ["Arranges views horizontally", "Supports alignment and spacing"]),
            Component(name: "VStack", iconName: "v.square", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/vstack")!, usageExample: "VStack { Text(\"Top\"); Text(\"Center\"); Text(\"Bottom\") }", keyFeatures: ["Arranges views vertically", "Supports alignment and spacing"]),
            Component(name: "ZStack", iconName: "z.square", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/zstack")!, usageExample: "ZStack { Text(\"Behind\"); Text(\"On top\") }", keyFeatures: ["Layers views on top of each other", "Supports z-index control"]),
            Component(name: "Form", iconName: "list.bullet", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/form")!, usageExample: "Form { TextField(\"Username\", text: $username) SecureField(\"Password\", text: $password) }", keyFeatures: ["Groups input elements", "Supports automatic layout adjustments"]),
            Component(name: "NavigationView", iconName: "rectangle.stack", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/navigationview")!, usageExample: "NavigationView { Text(\"Detail View\") }", keyFeatures: ["Provides navigation stack", "Supports navigation links"]),
            Component(name: "Alerts", iconName: "exclamationmark.circle", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/alert")!, usageExample: """
                Hi
                """, keyFeatures: ["Displays modal alerts", "Supports custom buttons"]),
            Component(name: "Sheets", iconName: "arrow.up.and.down.circle.fill", section: .containerViews, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/sheet")!, usageExample: "sheet(isPresented: $showingSheet) { Text(\"This is a sheet\") }", keyFeatures: ["Displays a modal sheet", "Supports custom views"]),

            // Lists
            Component(name: "Plain List", iconName: "list.bullet", section: .lists, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/list")!, usageExample: "List { Text(\"Item 1\"); Text(\"Item 2\") }", keyFeatures: ["Standard list view", "Supports data-driven rendering"]),
            Component(name: "Inset List", iconName: "list.bullet.indent", section: .lists, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/list")!, usageExample: "List { Text(\"Item 1\"); Text(\"Item 2\") }.listStyle(InsetGroupedListStyle())", keyFeatures: ["Inset style for lists", "Groups items for better presentation"]),
            Component(name: "Grouped List", iconName: "list.bullet.rectangle", section: .lists, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/list")!, usageExample: "List { Section(header: Text(\"Group 1\")) { Text(\"Item 1\") } }", keyFeatures: ["Grouped layout for lists", "Allows section headers"]),
            Component(name: "Inset Grouped List", iconName: "list.bullet.indent", section: .lists, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/list")!, usageExample: "List { Section(header: Text(\"Group 1\")) { Text(\"Item 1\") } }.listStyle(InsetGroupedListStyle())", keyFeatures: ["Grouped and inset style", "Flexible list section management"]),
            Component(name: "Sidebar List", iconName: "sidebar.left", section: .lists, documentationURL: URL(string: "https://developer.apple.com/documentation/swiftui/list")!, usageExample: "List { Text(\"Item 1\"); Text(\"Item 2\") }.listStyle(SidebarListStyle())", keyFeatures: ["Sidebar-style lists", "Ideal for navigation views"]),
        ]
    }
    
    var filteredComponents: [Component] {
        if searchQuery.isEmpty {
            return components
        } else {
            return components.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}




