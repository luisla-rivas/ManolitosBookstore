//
//  POrderListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct POrderListView: View {
    //@EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    let orders: BooksOrders
    var body: some View {
//        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(orders) { po in //, id:\.self
                    NavigationLink(value: po) {
                        OrderRowView(vm: ORowVM(order: po))
                            .frame(alignment: .leading )
                    }
                }
            }
//        }
    }
}

struct POrderListView_Previews: PreviewProvider {
    static var previews: some View {
        POrderListView(orders: BooksOrder.list)
    }
}
