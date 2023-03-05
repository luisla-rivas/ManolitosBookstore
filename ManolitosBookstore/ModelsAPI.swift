//
//  ModelsAPI.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 8/2/23.
//

import Foundation

// MARK: - RequesByEmail
struct RequestByEmail: Codable {
    let email: String
}

//   let booksOrderedAndReaded = try? JSONDecoder().decode(BooksOrderedAndReaded.self, from: jsonData)
// MARK: - BooksOrderedAndReaded
struct BooksOrderedAndReaded: Codable {
    let readed: [Int]
    let email: String
    let ordered: [Int]
}

//   let booksReaded = try? JSONDecoder().decode(BooksReaded.self, from: jsonData)
// MARK: - BooksReaded
struct BooksReaded: Codable {
    let books: [Int]
    let email: String
}

// MARK: - BooksOrderRequest
struct BooksOrderRequest: Codable {
    let email: String
    let pedido: [Int]
}

// MARK: - PurchaseOrderState
struct PurchaseOrderState: Codable {
    let estado: String
}


// MARK: - ModifyOrderStateRequest
struct ModifyOrderStateRequest: Codable {
    let id, estado, admin: String
}


// MARK: - UserError
struct UserError: Codable {
    let error: Bool
    let reason: String
}
