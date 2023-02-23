//
//  OrderDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderDetailView: View {
    @ObservedObject var vm:OrderDetailVM
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

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(vm: OrderDetailVM(order: .preview))
    }
}
