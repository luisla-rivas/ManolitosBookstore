//
//  QuantityAndReadedDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 8/3/23.
//

import SwiftUI

struct QuantityAndReadedDetailView: View {
    @EnvironmentObject var appVM: BooksViewModel
    @ObservedObject var vm: RowVM
    // MARK: - PROPERTY
    @State private var counter: Int = 1
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 6) {
                Button {
                    if counter > 1 {
                        counter -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle")
                }
                
                Text("\(counter)")
                    //.fontWeight(.semibold)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .frame(minWidth: 26)
                
                Button {
                    if counter < 9 {
                        counter += 1
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }
                Spacer()
                
                //Add to CART
                Button {
                    for _ in 1...counter{
                        appVM.myCart.append(vm.book.idAPI)
                    }
                } label: {
                    Text("Add to Cart".uppercased())
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background {
                    Color(uiColor: .systemBackground)
                }
                .clipShape(Capsule())
                
                Spacer()
                
                //Readed TAG
                Button {
                    appVM.toggleReaded(idsAPI:[vm.book.idAPI])
                } label: {
                    Image(systemName: appVM.iHaveReaded(idAPI: vm.book.idAPI) ? "bookmark.fill" : "bookmark.slash.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 0)
    //        .padding(.horizontal)
            .background(Color.myBackgroundColor)
            .font(.system(.title3, design: .rounded))
            .foregroundColor(Color.myBackgroundPurple)
    //        .foregroundColor(Color(uiColor: .label))
        .imageScale(.large)
        }
        Divider()
    }
}

struct QuantityAndReadedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuantityAndReadedDetailView(vm: RowVM(book: .preview))
            .environmentObject(BooksViewModel(.inPreview))
    }
}
