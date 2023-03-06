//
//  AccountDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI


struct AccountDetailView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //    @StateObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss
    @State private var presentEdit = false
    @State private var alertLogoutConfirmation = false
    
    var body: some View {
//        let _ = Self._printChanges()
        Form {
            Section {
                Text(appVM.currentUser?.name ?? "---")
                Text(appVM.currentUser?.email ?? "---")
            } header: {
                Text("User")
            }
            Section {
                Text(appVM.currentUser?.location ?? "---")
            } header: {
                Text("Billing Address")
            }
            
            if appVM.currentUser != nil {
                Button {
                    alertLogoutConfirmation.toggle()
                } label: {
                    Text("Sign Out").foregroundColor(.red)
                }
            } else {
                Button {
                    dismiss()
                    appVM.screen = .login
                } label: {
                    Text("Sign In").foregroundColor(.red)
                }
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Account")
//        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    Menu("Sort") {
            //                        ForEach(ScoresViewModel.SortType.allCases, id:\.self) { opcion in
            //                            Button {
            //                                scoresVM.sortType = opcion
            //                            } label: {
            //                                Text(opcion.rawValue)
            //                            }
            //                        }
            //                    }
            //                }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    presentEdit.toggle()
                } label: {
                    //Image(systemName: "edit")
                    Text("Edit")
                }
            }
        }
//        .fullScreenCover(isPresented: $presentEdit) {
//            Text("Edit User")
//        }
        .sheet(isPresented: $presentEdit) {
            Text("Edit User")
        }
//        .sheet(isPresented: $presentLogin) {
//            Text("Login")
//        }
        .alert("Sign out alert!",
               isPresented: $alertLogoutConfirmation) {
            Button(role: .destructive) {
                dismiss()
                appVM.logout()
            } label: {
                Text("Log Out").bold()
            }
            Button(role: .cancel) {
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("Please, confirm you want to log out.")
        }
    }
}


struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AccountDetailView()
                .environmentObject(BooksViewModel(.inPreview))
        }
    }
}
