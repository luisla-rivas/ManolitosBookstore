//
//  OrderedBookListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/3/23.
//

import SwiftUI

struct OrderedBookListView: View {
    let books: Books
    
    var body: some View {
        ForEach(books) { book in
            HStack {
                Text(book.title)
                Spacer()
                Text(book.price.inEuro)
            }
        }
    }
}

struct OrderedBookListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedBookListView(books: BooksViewModel(.inPreview).books)
    }
}
