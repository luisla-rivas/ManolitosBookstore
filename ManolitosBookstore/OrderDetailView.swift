//
//  OrderDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @ObservedObject var vm:OrderDetailVM
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                    .bold()
                Spacer()
                Text("State: **\(vm.state.capitalized)**")
                
            }
            Divider()
            
            //Text("**\(vm.numberPO)**")
            //Text(vm.email)
            //Text(vm.booksIdAPI)
            BookListView(books: appVM.booksWith(idsAPI: vm.order.books))
            
            Spacer()
        }
        .padding()
        .navigationTitle("Purchase order detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrderDetailView(vm: OrderDetailVM(order: .preview))
                .environmentObject(BooksViewModel(.inPreview))
        }
    }
}
