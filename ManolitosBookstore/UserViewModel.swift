//
//  UserViewModel.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import Foundation

final class UserViewModel: ObservableObject {
    private let persistence = ModelPersistence()
    
    private let user = BookstoreUser.preview
    
//    @Published var  firstName = ""
//    @Published var  lastName = ""
    @Published var  name = ""
    @Published var  email = ""
    @Published var  location = ""
    @Published var  role = Role.client

    
    init(user:BookstoreUser) {
//        self.user = user
        let user = BookstoreUser.preview
        name = user.name
        email = user.email
        location = user.location
        role = user.role
    }

    func saveInfo(user:BookstoreUser) -> BookstoreUser {
        return BookstoreUser(name: name, email: email, location: location, role: role)
    }

    var mustDisableSaveButton:Bool {
        return (name == user.name &&
            email == user.email &&
            location == user.location &&
            role == user.role)
    }
}
