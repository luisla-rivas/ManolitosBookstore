//
//  ContentAdminView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

enum TabAdmin {
  case books, customers, orders, setting //, account

}

struct ContentAdminView: View {
    @State private var selection: TabItem = .purchased
    
    var body: some View {
        TabView(selection: $selection) {
           
            BookstoreListView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill")
                }
                .tag(TabAdmin.books)
            
            BookstoreCustomerListView()
                .tabItem {
                    Label("Orders", systemImage: "magnifyingglass")
                }
                .tag(TabAdmin.orders)
            
            BookstoreCustomerListView()
                .tabItem {
                    Label("Customer", systemImage: "person.crop.circle.fill")
                }
                .tag(TabAdmin.customers)
            
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
    }
}
