//
//  CustomerListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct CustomerListView: View {
    //@EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    let customers: Clients
    var body: some View {
//        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(customers, id:\.self) { customer in
                    NavigationLink(value: customer) {
                        CustomerRowView(rowVM: CRowVM(customer: customer))
//                            .frame(alignment: .leading )
                    }.padding()
                }
            }
//        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView(customers: Client.list)
    }
}
