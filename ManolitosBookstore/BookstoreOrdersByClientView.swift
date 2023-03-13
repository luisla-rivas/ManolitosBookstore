//
//  BookstoreOrdersByClientView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 13/3/23.
//

import SwiftUI

struct BookstoreOrdersByClientView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    
    var body: some View {
        List(appVM.allOrdersGroupedByClient, id:\.self) { orders in
                CollapsibleSection(title: orders.first?.email ?? "") {
                        POrderListView(orders: orders)
                }
            }
            .listStyle(.inset)
    }
}

struct BookstoreOrdersByClientView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreOrdersByClientView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
