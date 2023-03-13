//
//  POrderListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct POrderListView: View {

    var orders: BooksOrders
    
    var body: some View {
//        VStack {
            ForEach(orders) { po in //, id:\.self
                NavigationLink(value: po) {
                    OrderRowView(vm: ORowVM(order: po))
                    //                    .frame(alignment: .leading )
                        .padding(.bottom, 10)
                }
            }.listRowSeparator(.hidden)
//        }
    }
}

struct POrderListView_Previews: PreviewProvider {
    static var previews: some View {
        POrderListView(orders: BooksOrder.list)
    }
}
