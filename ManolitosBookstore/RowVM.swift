//
//  RowVM.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 15/2/23.
//

import SwiftUI

final class RowVM:ObservableObject {
    private let persistenceAsync = AsyncPersistence.shared
    
    let book:Book
    
    @Published var cover: UIImage?
    @Published var title = ""
    @Published var authorName = "-"
    @Published var year = ""
   
    init(book:Book) {
        self.book = book
        self.title = book.title
        if let bookYear = book.year {
            self.year = String(bookYear)
        } else {
            self.year = ""
        }
        getBookCover()
        getBookAuthorName()
    }
    
    func getBookCover() {
        guard let imageURL = book.cover else { return }
        let url = URL.cachesDirectory.appending(path: imageURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: url.path()) {
            do {
                let data = try Data(contentsOf: url)
                self.cover = UIImage(data: data)
            } catch {
                print("Error en la carga \(imageURL).")
            }
        } else {
            Task { await getImageAsync() }
        }
    }
    
    func getBookAuthorName() {
        guard let authorID = book.author else { return }
        if let name = AuthorsStore.shared.nameForID[authorID] {
            authorName = name
            //print("getting author from BooksViewModel")
        } else {
            //Task { await getAuthorAsync() }
            //print("getting author async...")
        }
        
//        let url = URL.cachesDirectory.appending(path: authorID)
//        if FileManager.default.fileExists(atPath: url.path()) {
//            do {
//                let data = try Data(contentsOf: url)
//                self.author = UIImage(data: data)
//            } catch {
//                print("Error en la carga \(coverURL).")
//            }
//        } else {
//            Task { await getImageAsync() }
//        }
    }
    
    
    
//    var subscribers = Set<AnyCancellable>()
//
//    func getImageCombine() {
//        guard let avatar = empleado.avatar else { return }
//        CombinePersistence.shared.getImagePublisher(url: avatar)
//            .assign(to: \.avatar, on: self)
//            .store(in: &subscribers)
//    }
    
    @MainActor func getImageAsync() async {
        guard let imageURL = book.cover else { return }
        do {
            cover = try await AsyncPersistence.shared.getImage(url: imageURL)
        } catch {
            print("Error en la carga \(imageURL)")
        }
    }
    
    @MainActor func getAuthorAsync() async {
        guard let authorID = book.author else { return }
        do {
            let author = try await AsyncPersistence.shared.getAuthor(id: authorID)
            authorName = author.name
        } catch {
            print("Error en la carga \(authorID)")
        }
    }
}
