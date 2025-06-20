//
//  ContentView.swift
//  43.Navigation
//
//  Created by Валентин on 20.06.2025.
//

import SwiftUI

//Класс, в котором будем сохранять весь путь навигации между окнами
@Observable
class PathStore {
    //путь навигации
    var path: [Int] {
        didSet {
            //при каждом изменении массива навигации будем сохранять в JSON файле (чтобы восстановить после закрытия приложения)
            save()
        }
    }
    
    //путь сохранения
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    //в инициализаторе будем извлекать из JSON-файла
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }
        //если же декодировать из файла не получилось, то массив пути будет пустой
        path = []
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack (path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path)
                }
        }
    }
}

#Preview {
    ContentView()
}
