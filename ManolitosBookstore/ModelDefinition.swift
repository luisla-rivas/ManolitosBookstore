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

//   let user = try? JSONDecoder().decode(User.self, from: jsonData)
// MARK: - BookstoreUser
struct BookstoreUser: Codable {
    let name, email, location: String
    let role: Role
    
    static let preview = BookstoreUser(name: "Luis Tester", email: "luisla.tester@luisla.com", location: "C/Alegría de Swift, 77 /n08025 Barcelona", role: .admin)
}
enum Role: String, Codable, CaseIterable {
    case admin = "admin"
    case client = "usuario"
//    case client = "client"
//    case provider = "provider"
}



// MARK: - Book
struct Book: Identifiable, Codable, Hashable {
    let cover: String?
    let year: Int?
    let author: String?
    let rating: Double?
    let title: String
    let id: Int
    let isbn, summary: String?
    let pages: Int?
    
    static let preview = Book(cover: "https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png", year: 1955, author: "ED352A5F-D451-43AD-84E6-F896B1FF10D5", rating: 4.32, title: "The Dictator", id: 577, isbn: nil, summary: "Stephen Marlowe (born Milton Lesser) was an American author of science fiction, mystery novels, and fictional autobiographies of Christopher Columbus, Miguel de Cervantes, and Edgar Allan Poe. This is one of those stories.", pages: nil)
}
typealias Books = [Book]

//   let authors = try? JSONDecoder().decode(Authors.self, from: jsonData)
// MARK: - Author
struct Author: Identifiable, Codable, Hashable {
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



