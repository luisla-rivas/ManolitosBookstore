//
//  ModelDefinition.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let books = try? JSONDecoder().decode(Books.self, from: jsonData)

import Foundation

// MARK: - Book
struct Book: Codable {
    let cover: String?
    let year: Int?
    let author: String?
    let rating: Double?
    let title: String
    let id: Int
    let isbn, summary: String?
    let pages: Int?
}

typealias Books = [Book]


//   let authors = try? JSONDecoder().decode(Authors.self, from: jsonData)
// MARK: - Author
struct Author: Codable {
    let name, id: String
}

typealias Authors = [Author]

//   let client = try? JSONDecoder().decode(Client.self, from: jsonData)
// MARK: - Client
struct Client: Codable {
    let name, email, location, role: String
}

//   let order = try? JSONDecoder().decode(BooksOrder.self, from: jsonData)
// MARK: - BooksOrder / Confirmation
struct BooksOrder: Codable {
    let npedido: String
    let date: Date
    let estado: OrderState
    let email: String
    let books: [Int]
}

enum OrderState: String, Codable, CaseIterable {
    case recibido = "recibido"
    case enviado = "enviado"
    case entregado = "entregado"
}

//Struct used in POST requests or anwsers

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


typealias BooksOrders = [BooksOrder]

// MARK: - PurchaseOrderState
struct PurchaseOrderState: Codable {
    let estado: String
}


// MARK: - ModifyOrderStateRequest
struct ModifyOrderStateRequest: Codable {
    let id, estado, admin: String
}


