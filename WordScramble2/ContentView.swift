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

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            // onSubmit() needs to be give a function that accepts no
            // parameters and returns nothing.
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        // Lowercase and trim the word, to make sure we don't add duplicate
        // words with case differences.
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // Exit if the remaining string is empty
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original.")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'.")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }

    func startGame() {
        // 1. Find the URL for start.text in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // IF we are *here* then that was a problem - trigger a crash and report the error
        fatalError("Could not load start.ext from bundle.")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        // Make a copy of the root word for manipulation later on
        var tempRoot = rootWord

        for letter in word {
            if let pos = tempRoot.firstIndex(of: letter) {
                // If a letter from user's input word is found then remove
                // the letter from the copy so it can't be used twice.
                tempRoot.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
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
