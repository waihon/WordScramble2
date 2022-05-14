//
//  ContentView.swift
//  WordScramble2
//
//  Created by Waihon Yew on 14/05/2022.
//

import SwiftUI

struct ListView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        Form {
            List {
                Section("Section 1") {
                    Text("Static row 1")
                    Text("Static row 2")
                }

                Section("Section 2") {
                    ForEach(0..<3) {
                        Text("Dynamic row \($0)")
                    }
                }

                Section("Section 3") {
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }

            Section("Section 4") {
                List(0..<3) {
                    Text("Dynamic row \($0)")
                }
            }

            Section("Section 5") {
                List(people, id: \.self) {
                    Text($0)
                }
            }

            Section("Section 6") {
                List {
                    Text("Static row 1")

                    ForEach(people, id: \.self) {
                        Text($0)
                    }

                    Text("Static row 2")
                }
            }
        }
    }
}

struct ContentView: View {
    static let listStyleTexts = ["Automatic", "Grouped", "Inset", "Inset Grouped", "Plain", "Sidebar"]
    @State private var listStyleText = listStyleTexts[0]

    var body: some View {
        VStack {
            VStack {
                Text("List style:")
                Picker("List style", selection: $listStyleText) {
                    ForEach(Self.listStyleTexts, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }

            switch listStyleText {
            case "Grouped":
                ListView()
                    .listStyle(.grouped)
            case "Inset":
                ListView()
                    .listStyle(.inset)
            case "Inset Grouped":
                ListView()
                    .listStyle(.insetGrouped)
            case "Plain":
                ListView()
                    .listStyle(.plain)
            case "Sidebar":
                ListView()
                    .listStyle(.sidebar)
            default:
                ListView()
                    .listStyle(.automatic)
            }
        }
    }
}

struct List03ContentView: View {
    var body: some View {
        List {
            Text("Static row 1")
            Text("Static row 2")

            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }

            Text("Static row 3")
            Text("Static row 4")
        }
    }
}

struct List02ContentView: View {
    var body: some View {
        List {
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
        }
    }
}

struct List01ContentView: View {
    var body: some View {
        List {
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
