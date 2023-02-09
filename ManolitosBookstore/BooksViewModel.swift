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

final class BooksViewModel: ObservableObject {
    private let persistenceAsync = AsyncPersistence()
    private let persistence = ModelPersistence()
    @Published var books:Books = []
    private let authors:Authors = []
    @Published var search = ""
    
    @Published var showError = false
    @Published var errorMsg = "" {
        didSet {
            if !errorMsg.isEmpty {
                showError.toggle()
            }
        }
    }
    
    init(option:Option = .normal) {
        if option == .inPreview {
            
            self.books = persistence.loadJSON(url: .booksTestURL, arrayOf: Book.self)
//            self.seasons = Dictionary(grouping: episodes) { episode in
//                episode.season
//            }.keys.map { $0 }.sorted()
//            let fakeContext = PersistenceController.empty.container.viewContext
//            self.context = fakeContext
//            createDefaultUserInfo(episodes, context: fakeContext)
        } else {
//            let coreDataContext = PersistenceController.shared.container.viewContext
//            self.context = coreDataContext
//            self.episodes = persistence.loadJSON(arrayOf: BigBangEpisode.self)
//            self.seasons = Dictionary(grouping: episodes) { episode in
//                episode.season
//            }.keys.map { $0 }.sorted()
//
//            let request = CDUserEpisodeInfo.fetch(NSPredicate.all)
//            let resultUserEpisodesInfo = try? coreDataContext.fetch(request)
//            if let result = resultUserEpisodesInfo?.count, result > 0 {
//                //userEpisodeInfo is alredy in Database
//            } else {
//                createDefaultUserInfo(episodes, context: coreDataContext)
//            }
        }
        
        
    }
    @MainActor func getAllBooks() async {
        do {
            let booksFromServer = try await AsyncPersistence.shared.getAllBooks() //DataLoad.shared.loadEmpleadosData()
            books = booksFromServer
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    @MainActor func getLatestBooks() async {
        do {
            let booksFromServer = try await AsyncPersistence.shared.getLatestBooks() //DataLoad.shared.loadEmpleadosData()
            books = booksFromServer
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    

}
