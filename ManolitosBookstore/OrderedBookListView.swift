//
//  OrderedBookListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/3/23.
//

import SwiftUI

struct OrderedBookListView: View {
    let books: Books
    var total: Double {
        books.reduce(0.0) { result , book in
            result + (book.price ?? 0.0)
        }
    }
    
    var body: some View {
        VStack {
            ForEach(books) { book in
                HStack() {
                    Text(book.title)
                    Spacer()
                    Text(book.price.inEuro)
                }
            }
            HStack {
                Text("     Total amount:")
                Spacer()
                Text("\(total.inEuro)")
            }.padding(.top, 2)
        }
    }
}

struct OrderedBookListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedBookListView(books: Array(BooksViewModel(.inPreview).books.dropFirst(15)))
    }
}
