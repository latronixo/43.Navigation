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
    var path: NavigationPath {
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
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        //если же декодировать из файла не получилось, то массив пути будет пустой
        path = NavigationPath()
    }
    
    func save() {
        guard let representaion = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representaion)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack (path: $pathStore.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

#Preview {
    ContentView()
}
