//
//  AsyncPersistence.swift
//  ManolitosBookstore
//
//  Modified by Luis Lasierra on 9/2/23.
//  Created by Julio César Fernández Muñoz on 1/12/22.
//

import SwiftUI

final class AsyncPersistence {
    static let shared = AsyncPersistence()
    
    func getAllBooks() async throws -> Books {
        try await queryJSON(request: .request(url: .getAllBooks), type: Books.self)
    }
    
    func getLatestBooks() async throws -> Books {
        try await queryJSON(request: .request(url: .getLatestBooks), type: Books.self)
    }
    
    func getAuthors() async throws -> Authors {
        try await queryJSON(request: .request(url: .getAuthors), type: Authors.self)
    }
    func getAuthor(id: UUID) async throws -> Author {
        try await queryJSON(request: .request(url: .getAuthorFrom(id: id)), type: Author.self)
    }
    
    func checkUser(email: String) async throws -> Client {
        let userIdentity =  RequestByEmail(email: email) //Create post Struct for CallRequest
        let request = URLRequest.request(url: .postClientQuery, method: .post, body: userIdentity)
        let result = try await queryJSON(request: request, type: Client.self)
        return result
    }

    
    func getPurchasedBooks(email: String) async throws -> BooksOrderedAndReaded {
        let userIdentity =  RequestByEmail(email: email)
        let request = URLRequest.request(url: .postClientBooksReadedAndPurchaseQuery, method: .post, body: userIdentity)
        let result = try await queryJSON(request: request, type: BooksOrderedAndReaded.self)
        return result
    }
   
    
    func queryJSON<T:Codable>(request:URLRequest,
                              type:T.Type,
                              decoder:JSONDecoder = JSONDecoder(),
                              statusOK:Int = 200) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw APIErrors.nonHTTP }
            if response.statusCode == 200 {
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw APIErrors.json(error)
                }
            } else if response.statusCode == 404 {
                do {
                    let userError = try JSONDecoder().decode(UserError.self, from: data)
                    throw APIErrors.login(userError.reason)
                } catch let error as APIErrors {
                    throw error
                } catch  {
                    throw APIErrors.general(error)
                }
            } else {
                throw APIErrors.status(response.statusCode)
            }
        } catch let error as APIErrors {
            throw error
        } catch {
            throw APIErrors.general(error)
        }
    }
//    func queryJSON<T:Codable>(request:URLRequest,
//                              type:T.Type,
//                              decoder:JSONDecoder = JSONDecoder(),
//                              statusOK:Int = 200) async throws -> T {
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let response = response as? HTTPURLResponse else { throw APIErrors.nonHTTP }
//            if response.statusCode == 200 {
//                do {
//                    return try decoder.decode(T.self, from: data)
//                } catch {
//                    throw APIErrors.json(error)
//                }
//            } else {
//                throw APIErrors.status(response.statusCode)
//            }
//        } catch let error as APIErrors {
//            throw error
//        } catch {
//            throw APIErrors.general(error)
//        }
//    }

//    func query(request:URLRequest,
//               statusOK:Int = 200) async throws -> Bool {
//        do {
//            let (_, response) = try await URLSession.shared.data(for: request)
//            guard let response = response as? HTTPURLResponse else { throw APIErrors.nonHTTP }
//            if response.statusCode == statusOK {
//                return true
//            } else {
//                throw APIErrors.status(response.statusCode)
//            }
//        } catch let error as APIErrors {
//            throw error
//        } catch {
//            throw APIErrors.general(error)
//        }
//    }
//
    func getImage(url:URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        if let image, let data = image.pngData() {
            let url = URL.cachesDirectory.appending(path: url.lastPathComponent)
            try data.write(to: url, options: [.atomic])
        }
        return image
    }
}
