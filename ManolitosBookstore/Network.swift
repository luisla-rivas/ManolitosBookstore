//
//  Network.swift
//  ManolitosBookstore
//
//  Modified by Luis Lasierra on 8/2/23.
//  Created by Julio César Fernández Muñoz on 1/12/22.
//

import Foundation

let server = URL.serverProd

enum APIErrors:Error {
    case general(Error)
    case json(Error)
    case nonHTTP
    case status(Int)
    case invalidData
    case login(String)
    
    var description:String {
        switch self {
        case .general(let error):
            return "General error \(error)."
        case .json(let error):
            return "JSON error: \(error)."
        case .nonHTTP:
            return "Non HTTP connection."
        case .status(let int):
            return "Status error: \(int)."
        case .invalidData:
            return "Invalid data."
        case .login(let reason):
            return "Login fault: \(reason)"
        }
    }
}

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

let kBooks = "books"
let kClient = "client"
let kPurchase = "shop"
extension URL {
    static let serverProd = URL(string: "https://trantorapi-acacademy.herokuapp.com/api")!
    static let serverDesa = URL(string: "http://localhost:8080/api")!
    
    
    static let getLatestBooks = server.appending(path: kBooks).appending(path: "latest")
    static let getAllBooks = server.appending(path: kBooks).appending(path: "list")
    static let getAuthors = server.appending(path: kBooks).appending(path: "authors")
    static func getBooksWithTitle(containing search:String) -> URL {
        server.appending(path: kBooks).appending(path:"find").appending(path: "\(search)")
    }
    static func getAuthorFrom(id:UUID) -> URL {
        server.appending(path: kBooks).appending(path:"getAuthor").appending(path: "\(id)")
    }

    static let postAndPutClient = server.appending(path: kClient)
    static let postClientQuery = server.appending(path: kClient).appending(path: "query")
    static let postSetClientBooksReaded = server.appending(path: kClient).appending(path: "readQuery")
    static let postClientBooksReadedQuery = server.appending(path: kClient).appending(path: "readedBooks")
    static let postClientBooksReadedAndPurchaseQuery = server.appending(path: kClient).appending(path: "reportBooksUser")
    
    static let postNewPurchaseOrder = server.appending(path: kPurchase).appending(path: "newOrder")
    static let postClientPO = server.appending(path: kPurchase).appending(path: "orders")
    static let putPOStatus = server.appending(path: kPurchase).appending(path: "orderStatus")
    static func getPurchaseOrderInfoFor(id:String) -> URL {
         server.appending(path: kBooks).appending(path:"order").appending(path: "\(id)")
    }
    static func getPurchaseOrderStatusFor(id:String) -> URL {
         server.appending(path: kBooks).appending(path:"orderStatus").appending(path: "\(id)")
                         }
}

extension URLRequest {
    static func request(url:URL, method:HTTPMethod = .get) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue("Bearer 2p0847n p", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func request<T:Codable>(url:URL, method:HTTPMethod = .get, body:T) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
