//
//  AccountDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

//@StateObject var userVM = UserViewModel()
struct AccountDetailView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Name")
                    Text("email@email.com")
                } header: {
                    Text("")
                }
                Section {
                    Text("Calle del Swift, 77")
                    Text("08025 Barcelona")
                } header: {
                    Text("Billing Address")
                }
                Section {
                    Text("Calle del Swift, 77")
                    Text("08025 Barcelona")
                } header: {
                    Text("Shipping Address")
                }
                Button {
                    print("desconectando")
                } label: {
                    Text("Sign Out").foregroundColor(.red)
                }

            }
            .navigationTitle("Account")
        }
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView()
//            .environmentObject()
    }
}
