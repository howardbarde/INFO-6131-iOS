//  DetailView.swift
//  Assignment1
//
//  Created by Howard Barde on 3/15/25.
//

import SwiftUI
import SafariServices

struct DetailView: View {
    let component: Component
    @State private var showingSafari = false
    @State private var textFieldValue: String = ""
    @State private var secureFieldValue: String = ""
    @State private var selectedColor: Color = .red
    @State private var selectedDate: Date = Date()
    @State private var progress: Double = 50
    @State private var isEnabled: Bool = true
    @State private var stepperValue: Double = 0
    @State private var listData = ["Item 1", "Item 2", "Item 3"]
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var showingSheet = false

    var usageExampleView: some View {
        switch component.name {
        case "Text":
            return AnyView(Text("Hello, World!"))
        case "Label":
            return AnyView(Label("Username", systemImage: "person.circle"))
        case "TextField":
            return AnyView(TextField("Enter your name", text: $textFieldValue))
        case "SecureField":
            return AnyView(SecureField("Enter your password", text: $secureFieldValue))
        case "TextArea":
            return AnyView(TextEditor(text: $textFieldValue))
        case "Image":
            return AnyView(Image(systemName: "star.fill"))
        case "Button":
            return AnyView(Button("Click Me") {
                print("Button clicked")
            })
        case "Menu":
            return AnyView(Menu("Select Option") {
                Text("Option 1").onTapGesture { print("Option 1 selected") }
            })
        case "Link":
            return AnyView(Link("Visit Apple", destination: URL(string: "https://www.apple.com")!))
        case "Slider":
            return AnyView(Slider(value: $progress, in: 0...100))
        case "Stepper":
            return AnyView(Stepper("Stepper Value: \(Int(stepperValue))", value: $stepperValue, in: 0...10, step: 1))
        case "Toggle":
            return AnyView(Toggle("Enable feature", isOn: $isEnabled))
        case "Picker":
            return AnyView(Picker("Select a color", selection: $selectedColor) {
                Text("Red").tag(Color.red)
                Text("Blue").tag(Color.blue)
            })
        case "DatePicker":
            return AnyView(DatePicker("Select a date", selection: $selectedDate))
        case "ColorPicker":
            return AnyView(ColorPicker("Pick a color", selection: $selectedColor))
        case "ProgressView":
            return AnyView(ProgressView(value: progress, total: 100))
        case "HStack":
            return AnyView(HStack {
                ForEach(0..<5) { i in
                    Text("Item \(i)")
                }
            })
        case "VStack":
            return AnyView(VStack {
                ForEach(0..<5) { i in
                    Text("Item \(i)")
                }
            })
        case "ZStack":
            return AnyView(ZStack {
                Text("Behind")
                Text("On top")
            })
        case "Form":
            return AnyView(
                VStack {
                    Form {
                        Section(header: Text("Account Details")) {
                            TextField("Username", text: $textFieldValue)
                            SecureField("Password", text: $secureFieldValue)
                        }
                        Section(header: Text("Settings")) {
                            Toggle("Enable feature", isOn: $isEnabled)
                            DatePicker("Select a date", selection: $selectedDate)
                        }
                    }
                    .frame(height: 300)
                }
            )
        case "NavigationView":
            return AnyView(NavigationView {
                Text("Detail View")
            })
        case "Alerts":
            return AnyView(Button("Show Alert Example") {
                alertMessage = component.usageExample
                showAlert.toggle()
            })
        case "Sheets":
            return AnyView(Button("Show Sheet Example") {
                showingSheet.toggle()
            })
        case "Plain List":
            return AnyView(VStack {
                List {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
                .frame(height: 200)
            })
            
        case "Inset List":
            return AnyView(VStack {
                List(listData, id: \.self) { item in
                    Text(item)
                }
                .listStyle(InsetListStyle())
                .frame(height: 200)
            })
            
        case "Grouped List":
            return AnyView(VStack {
                List {
                    Section(header: Text("Group 1")) {
                        ForEach(listData, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .frame(height: 200)
            })
            
        case "Inset Grouped List":
            return AnyView(VStack {
                List {
                    Section(header: Text("Group 1")) {
                        ForEach(listData, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .frame(height: 200)
            })
            
        case "Sidebar List":
            return AnyView(VStack {
                List(listData, id: \.self) { item in
                    Text(item)
                }
                .listStyle(SidebarListStyle())
                .frame(height: 200)
            })

        default:
            return AnyView(EmptyView())
        }
    }


    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Usage Example:")
                    .font(.headline)
                
                usageExampleView
                    .padding(.bottom, 8)

                Text("Key Features:")
                    .font(.headline)
                
                ForEach(component.keyFeatures, id: \.self) { feature in
                    Text("• \(feature)")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle(component.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showingSafari.toggle()
                }) {
                    Image(systemName: "doc")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $showingSafari) {
            SFSafariViewControllerWrapper(url: component.documentationURL)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Usage Example"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $showingSheet) {
            VStack {
                Text("This is a sheet view example!")
                    .font(.title)

                Button("Dismiss") {
                    showingSheet.toggle()
                }
            }
        }
    }
}

struct SFSafariViewControllerWrapper: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
