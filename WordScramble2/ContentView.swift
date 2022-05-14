//
//  ContentView.swift
//  WordScramble2
//
//  Created by Waihon Yew on 14/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
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
