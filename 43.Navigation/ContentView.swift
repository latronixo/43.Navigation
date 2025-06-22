//
//  ContentView.swift
//  43.Navigation
//
//  Created by Валентин on 20.06.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .toolbar {
                    Button("Tap Me") {
                        
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
