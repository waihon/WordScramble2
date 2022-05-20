//
//  ContentView.swift
//  WordScramble2
//
//  Created by Waihon Yew on 14/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords = [String]()

    var body: some View {
        Text("Hello, world!")
    }
}

struct List05ContentView: View {
    @State private var string = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var trimmedString: String {
        string.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var wordOrPhrase: String {
        let stringArray = trimmedString.components(separatedBy: " ")
        if stringArray.count > 1 {
            return "phrase"
        } else {
            return "word"
        }
    }

    var stringIsEmpty: Bool {
        return trimmedString.isEmpty
    }

    var body: some View {
        Form {
            Section("Spelling Checker") {
                TextField("Enter a word or phrase", text: $string)
                Button("Check Spelling") {
                    if checkSpelling(of: string) {
                        alertTitle = "Correct"
                        alertMessage = "'\(string)' is a correct \(wordOrPhrase)."
                    } else {
                        alertTitle = "Wrong"
                        alertMessage = "'\(string)' is an incorrect \(wordOrPhrase)."

                    }
                    showingAlert = true
                }.disabled(stringIsEmpty)
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue") { }
        } message: {
            Text(alertMessage)
        }
    }

    func checkSpelling(of string: String) -> Bool {
        let checker = UITextChecker()

        // Ask Swift to create an Objective-C string range using the entire
        // length of all our characters.
        // UTF-16 is a character encoding which provides a nice bridging
        // format or us to connect Swift and Objective-C.
        let range = NSRange(location: 0, length: string.utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: string, range: range, startingAt: 0, wrap: false, language: "en")

        // If the Objective-C range comes back as empty - i.e., if there was
        // no spelling mistake because the string was spelled correctly -
        // then we get back the special value NSNotFound.
        return misspelledRange.location == NSNotFound
    }
}

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

struct List04ContentView: View {
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
