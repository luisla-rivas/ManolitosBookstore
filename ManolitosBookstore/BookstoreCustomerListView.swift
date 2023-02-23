//
//  BookstoreCustomerListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct BookstoreCustomerListView: View {
    //@EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        NavigationStack { //(path: $path)
            List {
                Section {
                    CustomerListView(customers: Client.list)
                } header: {
                    Text("Customers")
                }
            }.listStyle(.inset)
            .navigationDestination(for: Client.self) { customer in
                CustomerDetailView(vm: CRowVM(customer: customer))
            }
            .navigationTitle("Bookstore customers")
            //.searchable(text: $appVM.search)
//            .refreshable {
//                await appVM.getAllBooks()
//            }
        }
//        .searchable(text: $appVM.search)
//        .alert("Network alert!",
//               isPresented: $appVM.showError) {
//            Button {
//                appVM.errorMsg = ""
//            } label: {
//                Text("OK")
//            }
//        } message: {
//            Text(appVM.errorMsg)
//        }
//        .task {
//            let (_,_) = await (appVM.getAllBooks(), appVM.getAuthors())
//            appVM.createBookData(from: appVM.booksInServer)
//        }
    }
}

struct BookstoreCustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreCustomerListView()
            //.environmentObject(<#T##T#>)
    }
}
