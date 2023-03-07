//
//  BookstoreListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 13/2/23.
//

import SwiftUI

struct BookstoreListView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        NavigationStack { //(path: $path)
            List {
                Section {
                    BookListView(books:appVM.filteredBooks)
                } header: {
                    Text("Bookstore")
                }
                
            }
//            .listStyle(.inset)
//            .scrollContentBackground(.hidden)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: RowVM(book: book))
            }
            .navigationTitle("Trantor catalog")
            //.searchable(text: $appVM.search)
            .refreshable {
                await appVM.getAllBooks()
            }
        }
        
        .searchable(text: $appVM.search)
        .navigationTitle("Bookstore catalog")
        .alert("Network alert!",
               isPresented: $appVM.showError) {
            Button {
                appVM.errorMsg = ""
            } label: {
                Text("OK")
            }
        } message: {
            Text(appVM.errorMsg)
        }
//        .task {
//            let (_,_) = await (appVM.getAllBooks(), appVM.getAuthors())
//            appVM.createBookData(from: appVM.booksInServer)
//        }
    }
}

struct BookstoreListView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
