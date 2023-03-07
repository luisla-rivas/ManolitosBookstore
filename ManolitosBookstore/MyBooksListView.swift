//
//  MyBooksListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/3/23.
//

import SwiftUI

struct MyBooksListView: View {
    @EnvironmentObject var appVM:BooksViewModel
    
    var body: some View {
        NavigationStack { //(path: $path)
            List {
                Section {
                    BookListView(books:appVM.myFilteredBooks)
                } header: {
                    Text("Bookstore")
                }

            }
            
//            .listStyle(.inset)
//            .scrollContentBackground(.hidden)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: BookDetailViewModel(book: book))
            }
            .navigationTitle("Trantor catalog")
            //.searchable(text: $appVM.search)
            .refreshable {
                await appVM.getAllBooks()
            }
        }
        
        .searchable(text: $appVM.search)
        .navigationTitle("My book list")
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
        .task {
            let _ = await (appVM.getOrderedAndReadedBooksForCurrentUser())
        }
    }
}

struct MyBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
