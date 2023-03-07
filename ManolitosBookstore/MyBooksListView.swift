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
                    if appVM.currentUser != nil {
                        BookListView(books:appVM.myFilteredBooks)
                    } else {
                        Text("You must be logged to watch your purchase book list!")
                            .padding()
                            .lineLimit(2, reservesSpace: true)
                    }
                } header: {
                    Text("My Books")
                }
                
            }
            //.searchable(text: $appVM.search)
            //.listStyle(.inset)
            //.scrollContentBackground(.hidden)
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: RowVM(book: book))
            }
            .navigationTitle("My book list")
            
            .refreshable {
                await appVM.getAllBooks()
            }
            
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
                let _ = await appVM.getOrderedAndReadedBooksForCurrentUser()
            }
        }
    }
}

struct MyBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
