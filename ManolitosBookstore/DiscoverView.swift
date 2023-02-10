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
                    LHGridView(books:appVM.books)
                } header: {
                    Text("Latest books")
                }
                
                Section {
                    BookListView(books:appVM.books)
                } header: {
                    Text("Last Purchased")
                }
            }.listStyle(.grouped)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(detailVM: BookDetailViewModel(book: book))
            }
            .navigationTitle("Manolito's Bookstore")
            //.searchable(text: $appVM.search)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(BooksViewModel(option: .inPreview))
    }
}
