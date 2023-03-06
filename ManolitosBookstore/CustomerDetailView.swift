//
//  CustomerDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @ObservedObject var vm:CRowVM
    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    Text("**Name:** \(vm.name)")
                    Text("**Email:** \(vm.email)")
                    Text("**Location:** \(vm.location)")
                    if vm.customer.role == Role.admin {
                        Text("**Role:** \(vm.role)")
                    }
                    Spacer()
                }
            }
            ScrollView {
                Text("PO num 1")
                Text("PO num 1")
            }
        }
    }
}

struct CustomerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailView(vm: CRowVM(customer: .preview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)
    }
}
