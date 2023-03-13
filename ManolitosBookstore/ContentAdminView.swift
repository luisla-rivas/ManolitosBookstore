//
//  ContentAdminView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

enum TabAdmin {
  case books, orders, setting //, customers

}

struct ContentAdminView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @State private var selection: TabAdmin = .orders

    var body: some View {

        TabView(selection: $selection) {
           
            BookstoreListView()
                .tabItem {
                    Label("Catalog", systemImage: "books.vertical.fill")
                }
                .tag(TabAdmin.books)
            
            //BookstoreOrderListView()
            BookstoreOrderListView()
                .tabItem {
                    Label("Orders", systemImage: "creditcard.fill")
                }
                .tag(TabAdmin.orders)
            
            /*
            BookstoreCustomerListView()
                .tabItem {
                    Label("Customer", systemImage: "person.crop.circle.fill")
                }
                .tag(TabAdmin.customers)
            */
            
            SettingsListView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabAdmin.setting)
        }
    }
}

struct ContentAdminView_Previews: PreviewProvider {
    static var previews: some View {
        ContentAdminView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
