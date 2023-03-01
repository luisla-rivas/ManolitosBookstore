//
//  AccountDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI



struct AccountDetailView: View {
    @StateObject var userVM: UserViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Name")
                    Text("email@email.com")
                } header: {
                    Text("User")
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
        AccountDetailView(userVM: UserViewModel(user: .preview))
//            .environmentObject()
    }
}
