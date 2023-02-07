//
//  BookListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        NavigationStack { //(path: $path)
            ScrollView {
                Text("MyScrollView")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250,maximum: 350))]) {
                    ForEach(appVM.books) { book in //, id:\.self
                        NavigationLink(value: book) {
                            Text(book.title)
                        }
                    }
                }
            }.padding()
//            .navigationDestination(for: Int.self) { seasonNumber in
//                EpisodeListView(seasonSelected: seasonNumber, showOnlyFavorites: false)
//            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(detailVM: BookDetailViewModel(book: book))
            }
            .navigationTitle("Manolito's Bookstore")
            //.searchable(text: $appVM.search)
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView().environmentObject(BooksViewModel(option: .inPreview))
    }
}
