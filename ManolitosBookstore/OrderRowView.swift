//
//  OrderRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderRowView: View {
    @EnvironmentObject var appVM:BooksViewModel
    let vm:ORowVM
    
    var body: some View {
        HStack {
            Color.myBackgroundColor.frame(width: 8)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.order.date.formatted(date: .abbreviated, time: .omitted))
                        .bold()
                    Spacer()
                    Text("State: **\(vm.state.capitalized)**")
                    
                }
                Divider()
                
//                Text("**\(vm.numberPO)**")
//                    .lineLimit(1)
//                    .truncationMode(.middle)
//                    .font(.title3)
//                Text(vm.email)
//                Text(vm.booksIdAPI)
                OrderedBookListView(books: appVM.booksWith(idsAPI: vm.order.books))
                    .environmentObject(BooksViewModel(.inPreview))
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




