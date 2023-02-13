//
//  DiscoverView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 10/2/23.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        NavigationStack { //(path: $path)
            List {
                Section() {
                    LHGridView(books:appVM.latestBooks)
                } header: {
                    Text("Latest books")
                }
                
                Section {
                    BookListView(books:appVM.ordededBooks)
                } header: {
                    Text("Last Purchased")
                }
                Section {
                    BookListView(books:appVM.readedBooks)
                } header: {
                    Text("Readed Books")
                }
            }.listStyle(.grouped)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(detailVM: BookDetailViewModel(book: book))
            }
            .navigationTitle("Manolito's Bookstore")
            //.searchable(text: $appVM.search)
            .task {
                let (_,_) = await (appVM.getLatestBooks(), appVM.getOrderedAndReadedBooks())
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(BooksViewModel(option: .inPreview))
    }
}
