//
//  LHGridView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 10/2/23.
//

import SwiftUI

struct LHGridView: View {
    @EnvironmentObject var appVM: BooksViewModel
    let books:Books
    var body: some View {
        Group {
            ScrollView(.horizontal) {
                //LazyVGrid(columns: [GridItem(.adaptive(minimum: 250,maximum: 350))]) {
                LazyHGrid(rows: [GridItem(.fixed(300))], alignment: .center, spacing: 4) { //>iOS14
                    ForEach(books) { book in //, id:\.self
                        NavigationLink(value: book) {
                            BookGridView(rowVM: RowVM(book: book))
                        }
                    }
                }
            }
        }
    }
}

struct LHGridView_Previews: PreviewProvider {
    static var previews: some View {
        LHGridView(books: BooksViewModel(option: .inPreview).books)
    }
}
