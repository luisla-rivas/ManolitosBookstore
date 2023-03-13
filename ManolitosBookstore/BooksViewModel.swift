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
    @Published var myLastOrderedBooks: Books = []
    @Published var myPurchasedBooks: Books = []
    @Published var myPurchaseOrders: BooksOrders = []
    @Published var myCart: [Int] = []
    @Published var allOrdersInServer:BooksOrders = []
    private var booksInServer: Books = []
    private var latestBooksInServer: Books = []
    private var myReadedIDBooks = [Int]()
    private var myLastOrderedIDBooks = [Int]()
    private var myPurchasedIDBooks = [Int]()

    
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
            let decoderISO = JSONDecoder()
            decoderISO.dateDecodingStrategy = .iso8601
            let ordersFromJSON = persistence.loadJSON(url: .ordersTestURL, arrayOf: BooksOrder.self, decoder: decoderISO)
            self.myPurchaseOrders = ordersFromJSON
            self.currentUser = Client(name: "Luisla Tester", email: "luisla.tester@luisla.com", location: "Rue del Perceba 13", role: .admin)
            self.allOrdersInServer = ordersFromJSON
        }
    }
    
    enum ShowRead: String, CaseIterable {
        case onlyRead = "Only Read"
        case onlyNotRead = "Not Read"
        case all = "All Books"
    }
    //@Published var showOnlyFavorites = false
    @Published var showReadOrNotRead:ShowRead = .all
    //@Published var showOnlyPurchased:Bool = false
    
    //Books Purchased
    var myFilteredBooks:Books {
        return myPurchasedBooks.filter { book in //filter for Favorites
//            if showOnlyFavorites {
//                return self.isFavorite(id: book.id)
//            } else {
//                return true
//            }
//        }.filter { book in //filter for iHaveRead
            switch self.showReadOrNotRead {
            case .onlyRead:
                return self.iHaveReaded(idAPI: book.idAPI)
            case .onlyNotRead:
                return !self.iHaveReaded(idAPI: book.idAPI)
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
    
    //All Books
    var filteredBooks:Books {
        return books.filter { book in //filter for Favorites
//            if showOnlyFavorites {
//                return self.isFavorite(id: book.id)
//            } else {
//                return true
//            }
//        }.filter { book in //filter for iHaveRead
            switch self.showReadOrNotRead {
            case .onlyRead:
                return self.iHaveReaded(idAPI: book.idAPI)
            case .onlyNotRead:
                return !self.iHaveReaded(idAPI: book.idAPI)
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
    
    func bookWith(idAPI: Int) -> Book? {
        booksInServer.first(where: { $0.idAPI == idAPI })
    }
    
    func booksWith(idsAPI: [Int]) -> Books {
        let n = idsAPI.count
        let selected:Books = idsAPI.compactMap { bookID in
            booksInServer.first(where: { book in
            book.idAPI == bookID })
        }
        if selected.count == n {
            return selected
        } else {
            errorMsg = "Some book ids were not found!"
            showError.toggle()
            return []
        }
        
    }
    
    func updateStateIn(order: BooksOrder) {
        guard let index = allOrdersInServer.firstIndex(where: {$0.id == order.id}) else {
            return
        }
        allOrdersInServer.remove(at: index)
        allOrdersInServer.append(order)
    }
    
    //MARK: - READED
    
//    func isFavorite(id:Int) -> Bool {
//        favorites.fav.contains(where: { $0 == id })
//    }
    
    func iHaveReaded(idAPI: Int) -> Bool {
        myReadedIDBooks.contains(idAPI)
    }
    
    func toggleReaded(idsAPI: [Int]) {
        if let userEmail = currentUser?.email {
            let readedBooksByCurrentUser = BooksReaded(books: idsAPI, email: userEmail)
            Task(priority: .userInitiated) {
                await postToggle(booksReaded: readedBooksByCurrentUser)
            }
        }
    }
    
    @MainActor private func postToggle(booksReaded: BooksReaded) async {
        do {
            let ok = try await AsyncPersistence.shared.postToogle(booksReaded: booksReaded)
            if ok {
                await getOrderedAndReadedBooksForCurrentUser()
            }
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
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
    
    //MARK: Create User
    func tryCreate(user: Client) {
        Task(priority: .userInitiated) {
            await create(user: user)
        }
    }
        
    @MainActor private func create(user: Client) async { //
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
    
    //MARK: Update User
    func tryUpdate(user: Client) {
        Task(priority: .userInitiated) {
            await update(user: user)
        }
    }
    
    @MainActor private func update(user: Client) async { //
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
                let clientBooks = try await AsyncPersistence.shared.getPurchasedAndReadedBooks(email: email)
                let lastOrdered = booksInServer.filter { clientBooks.ordered.contains($0.idAPI) }
                self.myLastOrderedBooks = lastOrdered //Bug: Last ordered, not all orderd
                self.myLastOrderedIDBooks = clientBooks.ordered //
                let readed = booksInServer.filter { clientBooks.readed.contains($0.idAPI) }
                self.myReadedBooks = readed //prepareForView(books: readed)
                self.myReadedIDBooks = clientBooks.readed
            }
                
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    //MARK: - ORDERS

    enum ShowOrders: String, CaseIterable {
        case received = "Received PO"
        case sent = "Sent PO"
        case delivered = "Delivered PO"
        case all = "All Purchase Orders"
    }
    @Published var showByOrdersStatus:ShowOrders = .all
    @Published var groupOrdersByStatus:OrdersGroupedBy = .state
    
    var myOrdersGrouped:[[BooksOrder]] {
        Dictionary(grouping: myPurchaseOrders) { order in
            order.estado
        }
        .values.sorted(by: { $0.first?.date ?? Date.now < $1.first?.date ?? Date.now })
        .map { orders in
            orders.filter { order in
                switch self.showByOrdersStatus {
                case .received:
                    return order.estado == .recibido
                case .sent:
                    return order.estado == .enviado
                case .delivered:
                    return order.estado == .entregado
                case .all:
                    return true
                }
            }
        }
    }
    
    var allOrdersGroupedByState:[[BooksOrder]] {
        Dictionary(grouping: allOrdersInServer) { order in
            order.estado
        }
        .values //.sorted(by: { $0.first?.date ?? Date.now < $1.first?.date ?? Date.now })
        .map { orders in
            orders.filter { order in
                switch self.showByOrdersStatus {
                case .received:
                    return order.estado == .recibido
                case .sent:
                    return order.estado == .enviado
                case .delivered:
                    return order.estado == .entregado
                case .all:
                    return true
                }
            }
        }
    }
    
    var allOrdersGroupedByClient:[[BooksOrder]] {
        Dictionary(grouping: allOrdersInServer) { order in
            order.email
        }
        .values //.sorted(by: { $0.first?.date ?? Date.now < $1.first?.date ?? Date.now })
        .map { orders in
            orders.filter { order in
                switch self.showByOrdersStatus {
                case .received:
                    return order.estado == .recibido
                case .sent:
                    return order.estado == .enviado
                case .delivered:
                    return order.estado == .entregado
                case .all:
                    return true
                }
            }
        }
    }
 
    func tryPlaceOrder() {
        guard let email = currentUser?.email else { return
        }
        Task(priority: .userInitiated) {
            await placeOrder(request: BooksOrderRequest(email: email, pedido: myCart) )
        }
    }
    
    
    func tryModifyStateTo(_ state: OrderState, for orderID: UUID) {
        guard let email = currentUser?.email, currentUser?.role == .admin else { return
        }
        let request = APIModifyOrderStateRequest(id: orderID, admin: email, estado: state)
        Task(priority: .userInitiated) {
            await modifyOrderStatus(request: request)
        }
    }
        
    @MainActor private func placeOrder(request: BooksOrderRequest) async { //
        do {
            let confirmed = try await AsyncPersistence.shared.postPlaceNew(po: request)
            errorMsg = "Purchase Order placed correctly!\n\nState: \(confirmed.estado)"
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    
    @MainActor private func modifyOrderStatus(request poRequest: APIModifyOrderStateRequest) async { //
            do {
                let ok = try await AsyncPersistence.shared.putUpdateOrderStatus(po: poRequest)
                if ok {
                    errorMsg = "Status Order changed correctly!"
                    //await getAllOrders()
                }

            } catch let error as APIErrors {
                errorMsg = error.description
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    
    
    @MainActor func getOrdersForCurrentUser() async {
        if let email = currentUser?.email { //Only if a client is logged in
            do {
                let myOrdersFromServer = try await AsyncPersistence.shared.getPurchaseOrders(for: email )
                self.myPurchaseOrders = myOrdersFromServer
                
                //while not endPoint for purchasedBookList
                let myOrdersIDBooks = myOrdersFromServer.flatMap { po in
                    po.books
                }
                self.myPurchasedIDBooks = myOrdersIDBooks
                let purchasedBookList =   booksInServer.filter { myOrdersIDBooks.contains($0.idAPI) }
                self.myPurchasedBooks = purchasedBookList
            } catch let error as APIErrors {
                errorMsg = error.description
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    }
    
    @MainActor func getAllOrders() async {
        //https://trantorapi-acacademy.herokuapp.com/api/shop/allOrders
        if let email = currentUser?.email, currentUser?.role == .admin { //Only if a client is logged in
            do {
                let ordersFromServer = try await AsyncPersistence.shared.getAllOrdersInServer(email: email)
                allOrdersInServer = ordersFromServer
                //print("All Orders in Server Num: \(ordersFromServer.count)")
            } catch let error as APIErrors {
                errorMsg = error.description
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    }
    
    
}
