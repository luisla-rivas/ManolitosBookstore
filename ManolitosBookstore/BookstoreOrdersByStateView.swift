//
//  BookstoreOrdersByStateView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 13/3/23.
//

import SwiftUI

struct BookstoreOrdersByStateView: View {
    @EnvironmentObject var appVM:BooksViewModel
    
    var body: some View {
            List(appVM.allOrdersGroupedByState, id:\.self) { orders in
                
                Section {
                    if appVM.currentUser != nil {
                        POrderListView(orders: orders)
                    } else {
                        Text("You must be logged to watch your purchase orders list!")
                            .padding()
                            .lineLimit(2, reservesSpace: true)
                    }
                } header: {
                    Text(orders.first?.estado.rawValue.uppercased() ?? "")
                }
            }
//                CollapsibleSection(title: orders.first?.estado.rawValue.uppercased() ?? "") {
//                        POrderListView(orders: orders)
//                }
//            }
//            .listStyle(.inset)
    }
}

struct BookstoreOrdersByStateView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreOrdersByStateView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
