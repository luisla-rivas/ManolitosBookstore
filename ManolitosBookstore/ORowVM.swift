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
    @Published var state = ""
    @Published var booksIdAPI = ""
    

    
    init(order: BooksOrder) {
        self.order = order
        self.numberPO = "\(order.id)"
        self.email = order.email
        self.date =  DateFormatter.short.string(for: order.date) ?? "-"
        self.state = order.estado.rawValue
        self.booksIdAPI = order.books.reduce("") { "\($0), \($1)" }
    }
    
    
    
}
