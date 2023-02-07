//
//  BookDetailViewModel.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import Foundation
final class BookDetailViewModel: ObservableObject {
    
    @Published var book:Book
    
    init(book: Book){
        self.book = book
    }
    
    
}
