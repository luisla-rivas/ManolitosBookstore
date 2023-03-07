//
//  ModelPersistence.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import Foundation

extension URL {
    static let ordersTestURL = Bundle.main.url(forResource: "orders", withExtension: "json")!
    static let booksTestURL = Bundle.main.url(forResource: "latestBooks", withExtension: "json")!
    static let authorsTestURL = Bundle.main.url(forResource: "authors", withExtension: "json")!

    static let userInfoSaveURL = URL.documentsDirectory.appending(component: "ManolitosBookstoreData").appendingPathExtension("json")
}

final class ModelPersistence {
    func loadJSON<T:Codable>(url:URL = .userInfoSaveURL, arrayOf: T.Type, decoder: JSONDecoder = JSONDecoder() ) -> [T] {
 
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode([T].self, from: data)
        } catch {
            print("Error en la carga \(error)")
            return []
        }
    }
    

    func saveUser(info:Client) {
        // iOS 15, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(info)
            try data.write(to: .userInfoSaveURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error en la grabación del archivo \(error)")
        }
    }
}
