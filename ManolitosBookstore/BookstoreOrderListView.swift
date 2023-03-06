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
        Text("NavigationStack")
 /*
        NavigationStack { //(path: $path)
            List(appVM.ordersGrouped, id:\.self) { orders in
                Section {
                    POrderListView(orders: orders)
                } header: {
                    Text(orders.first?.estado.rawValue ?? "")
                }
            }.listStyle(.inset)
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: OrderDetailVM(order: po))
            }
            .navigationTitle("Purchase Orders")
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
  */
    }
}


struct BookstoreOrderListView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreOrderListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
