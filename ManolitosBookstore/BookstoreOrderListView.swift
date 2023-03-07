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
            List(appVM.myOrdersGrouped, id:\.self) { orders in
                Section {
                    POrderListView(orders: orders)
                } header: {
                    Text(orders.first?.estado.rawValue.uppercased() ?? "")
                }
            }
            .listStyle(.inset)
            //.searchable(text: $appVM.search)
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: OrderDetailVM(order: po))
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
