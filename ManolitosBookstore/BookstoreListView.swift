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
//                    ForEach(appVM.myFilteredBooks) { book in //, id:\.self
//                        NavigationLink(value: book) {
//                            BookRowView(rowVM: RowVM(book: book))
//                                .frame(alignment: .leading )
//                        }
//                    }
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
