//
//  CustomerRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct CustomerRowView: View {
    let rowVM:CRowVM
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(rowVM.name)
                    .font(.title3)
                Text(rowVM.location)
                Text(rowVM.email)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

struct CustomerRowView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerRowView(rowVM: CRowVM(customer: .preview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)
    }
}
