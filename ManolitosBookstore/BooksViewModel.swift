//
//  BooksViewModel.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

enum Option {
    case normal
    case inPreview
}
final class AuthorsStore {
    static let shared = AuthorsStore()
    private init() {}
    var nameForID = [UUID:String]()
}

final class BooksViewModel: ObservableObject {
    private let persistenceAsync = AsyncPersistence()
    private let persistence = ModelPersistence()
    private let authorsInServer = AuthorsStore.shared
    @Published var books:Books = []
    @Published var latestBooks:Books = []
    @Published var ordededBooks: Books = []
    @Published var readedBooks: Books = []
    private var booksInServer: Books = []
    private var latestBooksInServer: Books = []
    
    @Published var search = ""
    
    @Published var showError = false
    @Published var errorMsg = "" {
        didSet {
            if !errorMsg.isEmpty {
                showError.toggle()
            }
        }
    }
    
    init(_ option:Option = .normal) {
        if option == .inPreview {
//            let (_,_) = await (appVM.getAllBooks(), appVM.getAuthors())
            let booksFromJSON = persistence.loadJSON(url: .booksTestURL, arrayOf: Book.self)
            
            let authorsFromJSON = persistence.loadJSON(url: .authorsTestURL, arrayOf: Author.self)
            var authorsDict:[UUID:String] = [:]
            for author in authorsFromJSON {
                authorsDict[author.id] = author.name
            }
            authorsInServer.nameForID = authorsDict
            self.books = booksFromJSON
            //self.books = prepareForView(books: booksFromJSON)
        }
    }
//    func createBookData(from books: Books) {
//        var bookList:Books = []
//        for book in books {
//            var bookInfoView = book
//            if book.author != nil {
//                bookInfoView.author = authorsInServer[book.author!, default:  ""]
//            } else {
//                bookInfoView.author = ""
//            }
//            bookList.append(bookInfoView)
//        }
//        self.books = bookList
//    }
    
//    func prepareForView(books: Books) -> Books {
//        var bookList:Books = []
//        for var book in books {
//            if book.author != nil {
//                book.author = authorsInServer[book.author!, default:  ""]
//            } else {
//                book.author = ""
//            }
//            bookList.append(book)
//        }
//        return bookList
//    }
    
    func authorName(for book: Book) -> String {
        if let authorID = book.author {
            if let authorName = authorsInServer.nameForID[authorID] {
                return authorName
            } else {
//                do {
//                    Task(priority:.utility) {
//                        let author = try await persistenceAsync.getAuthor(id: authorID)
//                        MainActor(
//                    }
//                    return author.name
//                } catch {
//                    return ""
//                }
            }
        }
        return ""
    }
    
    
    @MainActor func getAllBooks() async {
        do {
            let booksFromServer = try await AsyncPersistence.shared.getAllBooks() //DataLoad.shared.loadEmpleadosData()
            booksInServer = booksFromServer
            books = booksFromServer //prepareForView(books: booksFromServer)
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    @MainActor func getLatestBooks() async {
        do {
            let booksFromServer = try await AsyncPersistence.shared.getLatestBooks() //DataLoad.shared.loadEmpleadosData()
            latestBooksInServer = booksFromServer // prepareForView(books: booksFromServer)
            latestBooks = booksFromServer //prepareForView(books: booksFromServer)
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    @MainActor func getAuthors() async {
        do {
            let authorsFromServer = try await AsyncPersistence.shared.getAuthors()
            var authorsDict:[UUID:String] = [:]
            for author in authorsFromServer {
                authorsDict[author.id] = author.name
            }
            authorsInServer.nameForID = authorsDict
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    @MainActor func getOrderedAndReadedBooks() async {
        do {
            let clientBooks = try await AsyncPersistence.shared.getPurchasedBooks() //DataLoad.shared.loadEmpleadosData()
            let ordered = booksInServer.filter { clientBooks.ordered.contains($0.idAPI) }
            self.ordededBooks = ordered //prepareForView(books: ordered)
            let readed = booksInServer.filter { clientBooks.readed.contains($0.idAPI) }
            self.readedBooks = readed //prepareForView(books: readed)
            
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
}
