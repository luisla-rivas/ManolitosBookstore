//
//  ReviewBooksOrderingView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 9/3/23.
//

import SwiftUI

struct ReviewBooksOrderingView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @Binding var showView:Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Label("My Cart", systemImage: "cart").font(.title).padding(.bottom)
                Spacer()
                Button() {
                    showView.toggle()
                } label: {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Text("Done")
                    } else {
                        Circle()
                            .fill(Color(uiColor: .lightGray))
                            .frame(width: 20)
                            .overlay(alignment: .center) {
                                Text("X")
                            }
                    }
                }
            }
            HStack {
                Color.myBackgroundColor.frame(width: 8)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                            .bold()
                        Spacer()
                        
                    }
                    Divider()
                    
                    //                Text("**\(vm.numberPO)**")
                    //                    .lineLimit(1)
                    //                    .truncationMode(.middle)
                    //                    .font(.title3)
                    //                Text(vm.email)
                    //                Text(vm.booksIdAPI)
                    OrderingBookListView(books: appVM.booksWith(idsAPI: appVM.myCart)).padding()
                    Spacer()
                    Button {
                        //appVM.tryPlaceOrder()
                    } label: {
                        Spacer()
                        Text("Place Order".uppercased())
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background {
                        Color.myBackgroundColor
                    }
                    .clipShape(Capsule())
                }
            }
            
        }.padding()
    }
}


struct ReviewBooksOrderingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewBooksOrderingView(showView: .constant(.init(true)))
            .environmentObject(BooksViewModel(.inPreview))
    }
}
