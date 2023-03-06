//
//  EditCustomerView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 6/3/23.
//

import SwiftUI

struct EditCustomerView: View {
    @EnvironmentObject var appVM: BooksViewModel
    @ObservedObject var vm: UserViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState var field: DetailField?

    var body: some View {
        VStack {
            myNavigationSheet
            Form {
                Section {
                    MyTextField(label: "Name", text: $vm.name, validation: vm.fieldNotEmpty)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .focused($field, equals: .name)
                    MyTextField(label: "Email", text: $vm.email, validation: vm.validateEmail)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($field, equals: .email)
                } header: {
                    Text("Personal data")
                }
                
                Section {
                    MyTextField(label: "Address", text: $vm.location, validation: vm.fieldNotEmpty)
                        .textContentType(.fullStreetAddress)
                        .textInputAutocapitalization(.words)
                        .focused($field, equals: .location)
                } header: {
                    Text("Delivery Address")
                }
            }
        }

        //.navigationTitle(vm.user == nil ? "New user" : "Edit User")
        //.navigationBarTitleDisplayMode(vm.user == nil ? .large : .inline)
        .toolbar {
            /* used in Navigation Detail View           ToolbarItem(placement: .confirmationAction) {
                if vm.user == nil {
                    Button {
                        appVM.create(user: vm.createUser())
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                } else {
                    Button {
                        appVM.create(user: vm.updateUser())
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if vm.user == nil {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
         */
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button {
                        field?.prev()
                    } label: {
                        Image(systemName: "chevron.up")
                    }
                    Button {
                        field?.next()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    Spacer()
                    Button {
                        field = nil
                    } label: {
                        Image(systemName: "keyboard")
                    }
                }
            }
        }

    }
    
    var myNavigationSheet: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            Spacer()
            Text("\(vm.user == nil ? "New user" : "Edit User")")
            Spacer()
            if vm.user == nil {
                Button {
                    vm.createUser()
                    dismiss()
                } label: {
                    Text("Add")
                }
            } else {
                Button {
                    vm.updateUser()
                    dismiss()
                } label: {
                    Text("Save")
                    
                }.disabled(vm.mustDisableSaveButton)
            }
            
        }.padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditCustomerView(vm: UserViewModel(user: Client.preview))
        }
    }
}
//struct EditCustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCustomerView()
//    }
//}



enum DetailField {
    case name, email, location
    
    mutating func next() {
        switch self {
        case .name:
            self = .email
        case .email:
            self = .location
        case .location:
            self = .name
        }
    }
    
    mutating func prev() {
        switch self {
        case .name:
            self = .location
        case .email:
            self = .name
        case .location:
            self = .email
        }
    }
}
