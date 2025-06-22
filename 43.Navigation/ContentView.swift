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
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Button("Or tap Me") {
                            
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
