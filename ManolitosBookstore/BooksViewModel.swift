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
    enum Screens {
        case splash
        case welcome
        case login
        case access
    }
    
    enum SortType:String {
        case ascendent = "Ascendent"
        case descendent = "Descendent"
        case none = "None"
    }
    
    private let persistenceAsync = AsyncPersistence()
    private let persistence = ModelPersistence()
    private let authorsInServer = AuthorsStore.shared
    var currentUser: Client?
    @Published var screen:Screens = .splash
    @Published var books:Books = []
    @Published var latestBooks:Books = []
    @Published var readedAndOrderedBooks: [BooksOrderedAndReaded] = []
    @Published var myReadedBooks: Books = []
    @Published var myOrderedBooks: Books = []
    private var booksInServer: Books = []
    private var latestBooksInServer: Books = []
    private var myReadedIDBooks = [Int]()
    private var myOrderedIDBooks = [Int]()
    private var ordersInServer:BooksOrders = []
    
    var showingProduct = false
    
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
    
    enum ShowRead: String, CaseIterable {
        case onlyRead = "Only Read"
        case onlyNotRead = "Not Read"
        case all = "All Books"
    }
    @Published var showOnlyFavorites = false
    @Published var showReadOrNotRead:ShowRead = .all
    
    var myFilteredBooks:Books {
        return books.filter { book in //filter for Favorites
//            if showOnlyFavorites {
//                return self.isFavorite(id: episode.id)
//            } else {
//                return true
//            }
//        }.filter { book in //filter for iHaveRead
            switch self.showReadOrNotRead {
            case .onlyRead:
                return self.iHaveReaded(id: book.idAPI)
            case .onlyNotRead:
                return !self.iHaveReaded(id: book.idAPI)
            case .all:
                return true
            }
        }.filter { book in //filter for Search
            if search.isEmpty {
                return true
            } else {
                return book.title.lowercased().contains(search.lowercased())
            }
        }
    }
//    func isFavorite(id:Int) -> Bool {
//        favorites.fav.contains(where: { $0 == id })
//    }
    
    func iHaveReaded(id: Int) -> Bool {
        myReadedIDBooks.contains(id)
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
    
    
    
    
    
    
    
   //MARK: - LOGINs
    
    
    func logout(){
        UserDefaults.standard.set("-", forKey: .kUserMail)
        currentUser = nil
        screen = .welcome
    }
    
    func tryLogin(email: String) {
        if !email.isEmpty {
            Task(priority: .userInitiated) {
                    await getLoginUser(email: email)
                }
            }
    }
    
    func tryAutomaticLogin() {
        //UserDefaults.standard.set("luisla.tester@luisla.cm", forKey: .kUserMail) //To force wrong user in testing
        if let userEmail = UserDefaults.standard.string(forKey: .kUserMail) {
            Task(priority: .userInitiated) {
                await getLoginUser(email: userEmail)
            }
        }
    }
    func tryCreate(user: Client) {
        Task(priority: .userInitiated) {
            await create(user: user)
        }
    }

    
    
    @MainActor func getLoginUser(email: String) async {
        do {
            let user = try await AsyncPersistence.shared.checkUser(email: email)
            UserDefaults.standard.set(user.email, forKey: .kUserMail)
            currentUser = user
            screen = .access
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    func tryCreate(user: Client) {
        Task(priority: .userInitiated) {
            await create(user: user)
        }
    }
        
    @MainActor func create(user: Client) async { //
            do {
                let ok = try await AsyncPersistence.shared.postCreateUser(customer: user)
                if ok {
                    UserDefaults.standard.set(user.email, forKey: .kUserMail)
                    currentUser = user
                    screen = .access
                }
            } catch let error as APIErrors {
                errorMsg = error.description
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    
    
    func tryUpdate(user: Client) {
        Task(priority: .userInitiated) {
            await create(user: user)
        }
    }
    
    @MainActor func update(user: Client) async { //
            do {
                let ok = try await AsyncPersistence.shared.putUpdateUser(customer: user)
                if ok {
                    UserDefaults.standard.set(user.email, forKey: .kUserMail)
                    currentUser = user
                    screen = .access
                }
            } catch let error as APIErrors {
                errorMsg = error.description
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    
    //MARK: - @MainActor get AllBooks
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
    
    @MainActor func getOrderedAndReadedBooksForCurrentUser() async {
        do {
            if let email = currentUser?.email { //Only if a client is logged in
                let clientBooks = try await AsyncPersistence.shared.getPurchasedBooks(email: email)
                let ordered = booksInServer.filter { clientBooks.ordered.contains($0.idAPI) }
                self.myOrderedBooks = ordered //prepareForView(books: ordered)
                let readed = booksInServer.filter { clientBooks.readed.contains($0.idAPI) }
                self.myReadedBooks = readed //prepareForView(books: readed)
                self.myReadedIDBooks = clientBooks.readed
                self.myOrderedIDBooks = clientBooks.ordered
                //print("\(email) ha solicitado los libros leidos y comprados")
                //print("\(clientBooks)")
                //print("Readed: \(readed)")
            }
                
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    //MARK: - ADMIN procedures ORDERS
    enum ShowOrders: String, CaseIterable {
        case received = "Received PO"
        case sent = "Sent PO"
        case delivered = "Delivered PO"
        case all = "All Purchase Orders"
    }
    @Published var showByOrdersStatus:ShowOrders = .all
    
//    var ordersGrouped:[[BooksOrder]] {
//        Dictionary(grouping: ordersInServer) { order in
//            order.estado
//        }
//        .values.sorted(by: { $0.first?.estado.rawValue ?? "" < $1.first?.estado.rawValue ?? "" })
//        .map { orders in
//            orders.filter { order in
//                switch self.showByOrdersStatus {
//                case .received:
//                    return order.estado == .recibido
//                case .sent:
//                    return order.estado == .enviado
//                case .delivered:
//                    return order.estado == .entregado
//                case .all:
//                    return true
//                }
//            }
//        }
//    }
    
    
    @MainActor func getAllOrders() async {
        //https://trantorapi-acacademy.herokuapp.com/api/shop/allOrders
        do {
            let ordersFromServer = try await AsyncPersistence.shared.getAllOrders()
            ordersInServer = ordersFromServer
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
}
