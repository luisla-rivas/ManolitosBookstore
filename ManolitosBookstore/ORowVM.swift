//
//  ORowVM.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import Foundation
final class ORowVM:ObservableObject {
    private let persistenceAsync = AsyncPersistence.shared
    
    let order:BooksOrder
    
    @Published var numberPO = ""
    @Published var email = ""
    @Published var date = ""
    @Published var state:OrderState = .recibido
    @Published var booksIdAPI = ""
    
    @Published var selectedState:OrderState = .recibido
    
    init(order: BooksOrder) {
        self.order = order
        self.numberPO = "\(order.id)"
        self.email = order.email
        self.date =  DateFormatter.short.string(for: order.date) ?? "-"
        self.state = order.estado
        self.selectedState = order.estado
        self.booksIdAPI = order.books.reduce("") { "\($0), \($1)" }
    }
    
    
    func save() -> BooksOrder {
        BooksOrder(id: order.id, date: order.date, estado: selectedState, email: order.email, books: order.books)
    }
}
