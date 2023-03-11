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
                    if appVM.myLastOrderedBooks.count > 0 {
                        BookListView(books:appVM.myLastOrderedBooks)
                    } else {
                        Text("No purchased books yet.").font(.caption)
                    }
                } header: {
                    Text("Last Purchased")
                }
                Section {
                    if appVM.myReadedBooks.count > 0 {
                        BookListView(books:appVM.myReadedBooks)
                    } else {
                        Text("No readed books yet.").font(.caption)
                    }
                } header: {
                    Text("Readed Books")
                }
            }.listStyle(.grouped)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: RowVM(book: book))
            }
            .navigationTitle("Manolito's Bookstore")
            .refreshable {
                let (_,_) = await (appVM.getLatestBooks(), appVM.getOrderedAndReadedBooksForCurrentUser())
            }
            .onAppear() {
                Task { await appVM.getOrderedAndReadedBooksForCurrentUser()
                }
            }
            
            //.background(Color("launchBlackgroundColor"))
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
