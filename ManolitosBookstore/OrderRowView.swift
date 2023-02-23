//
//  OrderRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderRowView: View {
    let vm:ORowVM
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Purchase Order Number:")
                    //.font(.title3)
                Text("**\(vm.numberPO)**")
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .font(.title3)
                Text(vm.email)
                Text(vm.date)
                    .font(.caption)
                Text(vm.date)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(vm: ORowVM(order: .preview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)
    }
}




