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
            VStack {
                Picker ("Grouping by", selection:$appVM.groupOrdersByStatus) {
                    ForEach(OrdersGroupedBy.allCases,id:\.self) { groupBy in
                        Text(groupBy.rawValue)
                    }
                }.pickerStyle(.segmented)
                    .padding()

                switch appVM.groupOrdersByStatus {
                case .state:
                    BookstoreOrdersByStateView()
                case .client:
                    BookstoreOrdersByClientView()
                }
                Spacer()
            }
            //.searchable(text: $appVM.search)
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: ORowVM(order: po))
            }
//            .navigationDestination(for: Book.self) { book in
//                BookDetailView(vm: RowVM(book: book))
//            }
            .navigationTitle("Purchase Orders")
            .refreshable {
                await appVM.getAllOrders()
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
                await appVM.getAllOrders()
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


