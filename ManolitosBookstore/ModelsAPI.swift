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

// MARK: - APIPurchaseOrderState
struct APIPurchaseOrderState: Codable {
    let estado: String
}


// MARK: - APIModifyOrderStateRequest
struct APIModifyOrderStateRequest: Codable {
    let id: UUID
    let admin: String
    let estado: OrderState
}


// MARK: - UserError
struct UserError: Codable {
    let error: Bool
    let reason: String
}
