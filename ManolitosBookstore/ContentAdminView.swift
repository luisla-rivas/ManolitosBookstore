//
//  ContentAdminView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

enum TabAdmin {
  case books, orders, setting, myOrders //, customers

}

struct ContentAdminView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @State private var selection: TabAdmin = .books

    var body: some View {

        TabView(selection: $selection) {
           
            BookstoreListView()
                .tabItem {
                    Label("Catalog", systemImage: "books.vertical.fill")
                }
                .tag(TabAdmin.books)
            
            BookstoreOrderListView()
                .tabItem {
                    Label("Orders", systemImage: "creditcard.fill")
                }
                .tag(TabAdmin.orders)
        
            
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
