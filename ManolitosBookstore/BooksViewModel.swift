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
    
    @Published var books:Books = []
    
    @Published var search = ""
    
    init(option:Option = .normal) {
        if option == .inPreview {
//            self.episodes = persistence.loadJSON(url: .episodesTestURL, arrayOf: BigBangEpisode.self)
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
    
}
