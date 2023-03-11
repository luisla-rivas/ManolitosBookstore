//
//  BookstoreOrderListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct BookstoreOrderListView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        NavigationStack { //(path: $path)
            List(appVM.allOrdersGrouped, id:\.self) { orders in
                
                Section {
                    if appVM.currentUser != nil {
                        POrderListView(orders: orders)
                    } else {
                        Text("You must be logged to watch all purchase orders list!")
                            .padding()
                            .lineLimit(2, reservesSpace: true)
                    }
                } header: {
                    Text(orders.first?.estado.rawValue.uppercased() ?? "")
                }
            }
            .listStyle(.inset)
            //.searchable(text: $appVM.search)
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: ORowVM(order: po))
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: RowVM(book: book))
            }
            .navigationTitle("Purchase Orders")
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
                let _ = await appVM.getOrdersForCurrentUser()
            }
        }

    }
}


struct BookstoreOrderListView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreOrderListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
