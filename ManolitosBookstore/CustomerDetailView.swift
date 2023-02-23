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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
