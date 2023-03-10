//
//  OrderingBookListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 10/3/23.
//

import SwiftUI

struct OrderingBookListView: View {
    @EnvironmentObject var appVM: BooksViewModel
    let books: Books
    var total: Double {
        books.reduce(0.0) { result , book in
            result + (book.price ?? 0.0)
        }
    }
    
    var body: some View {
        ForEach(books) { book  in
            HStack(spacing: 4) {
                Text(book.title)
                Spacer()
                Button {
                    if let index = appVM.myCart.firstIndex(where: {$0 == book.idAPI} ) {
                        appVM.myCart.remove(at: index) }
                } label: {
                    Image(systemName: "trash.circle").imageScale(.large)
                }
                
                Text(book.price.inEuro)

            }
        }
        HStack {
            Text("     Total amount:")
            Spacer()
            Text("\(total.inEuro)")
        }.padding(.top, 2)
    }
    
}

struct OrderingBookListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderingBookListView(books: BooksViewModel(.inPreview).books)
            .environmentObject(BooksViewModel(.inPreview))
    }
}
