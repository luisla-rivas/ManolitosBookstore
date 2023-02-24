//
//  CRowVM.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import Foundation
final class CRowVM:ObservableObject {
    private let persistenceAsync = AsyncPersistence.shared
    
    let customer:Client
    
    @Published var name = ""
    @Published var email = ""
    @Published var location = ""
    @Published var role = ""
    
    init(customer: Client) {
        self.customer = customer
        self.name = customer.name
        self.email = customer.email
        self.location = customer.location
        self.role = customer.role.rawValue
        
    }
    
//    func getBookCover() {
//        guard let imageURL = book.cover else { return }
//        let url = URL.cachesDirectory.appending(path: imageURL.lastPathComponent)
//        if FileManager.default.fileExists(atPath: url.path()) {
//            do {
//                let data = try Data(contentsOf: url)
//                self.cover = UIImage(data: data)
//            } catch {
//                print("Error en la carga \(imageURL).")
//            }
//        } else {
//            Task { await getImageAsync() }
//        }
//    }
    
//    func getBookAuthorName() {
//        guard let authorID = book.author else { return }
//        if let name = AuthorsStore.shared.nameForID[authorID] {
//            authorName = name
//            //print("getting author from BooksViewModel")
//        } else {
//            //Task { await getAuthorAsync() }
//            //print("getting author async...")
//        }
//    }
}
