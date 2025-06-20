//
//  ContentView.swift
//  43.Navigation
//
//  Created by Валентин on 20.06.2025.
//

import SwiftUI
//
//struct DetailView: View {
//    var number: Int
//    
//    var body: some View {
//        Text("Detail View \(number)")
//    }
//    
//    init(number: Int) {
//        self.number = number
//        print("Creating detail view \(number)")
//    }
//}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<1000) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
