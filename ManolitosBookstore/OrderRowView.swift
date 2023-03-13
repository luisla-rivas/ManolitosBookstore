//
//  OrderRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderRowView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @ObservedObject var vm:ORowVM
    
    var body: some View {
        HStack {
            Color.myBackgroundColor.frame(width: 8)
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.order.date.formatted(date: .abbreviated, time: .omitted))
                        .bold()
                    Spacer()
                    Text("State: ")
                    Text(vm.state.rawValue.capitalized).font(.custom("Avenir Next Condensed", size: 20))
                    
                }
                if appVM.currentUser?.role == .admin {
                    HStack {
                        Text("Customer:")
                        Spacer()
                        Text(vm.order.email).font(.custom("Avenir Next Condensed", size: 20))
                    }
                }
                Divider()
//                Text("**\(vm.numberPO)**")
//                    .lineLimit(1)
//                    .truncationMode(.middle)
//                    .font(.title3)
//                Text(vm.email)
//                Text(vm.booksIdAPI)
                OrderedBookListView(books: appVM.booksWith(idsAPI: vm.order.books))
                Spacer()
            }
        }
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(vm: ORowVM(order: .preview))
            .environmentObject(BooksViewModel(.inPreview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)
    }
}




