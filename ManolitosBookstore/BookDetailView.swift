//
//  BookDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var appVM: BooksViewModel
    @ObservedObject var vm: RowVM//BookDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State var ratingDetent = false
    @State var isEditing = false
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // NAVBAR
            //            NavigationBarDetailView()
            //                .padding(.horizontal)
            //                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            HeaderDetailView(vm: vm)
                .padding(.horizontal)
            
            TopPartDetailView(vm: vm)
                .padding(.horizontal)
                .zIndex(1)
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    VStack(alignment: .leading ,spacing: 8) {
                        Text("Rating").bold()
                        //.frame(width: .infinity)
                        RatingView(rating: vm.book.rating ?? 0.0, maxRating: 5).frame(maxWidth: 100)
                    }
                    Spacer()
                }.padding(.top, -70)
               

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading,spacing: 8) {
                    HStack {
                        Text("**ISBN:** \(vm.book.isbn ?? "")  (\(vm.year))")
                        Spacer()
                        Text("**\(vm.book.pages ?? 0 ) pages** ")
                    }.padding(.bottom, 8)
//                    HStack {
//
//
//                        Text("Year: **\(vm.year)**")
//                        Spacer()
//                        Text("ISBN: \(vm.book.isbn ?? "")").bold()
//                    }
                    //Summary
                    Text("Summary").bold()
                    Text(vm.book.summary ?? "")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.leading)
                    }
                }
            

                
//                AddToCartDetailView()
//                    .padding(.vertical, 10)
            }
            .padding()//(.horizontal)
            .background {
                Color.white
                    .clipShape(CustomShape())
                    .padding(.top, -85)
            }
            QuantityAndReadedDetailView(vm: vm)
                .padding(.horizontal)
//            Spacer()
        }
        .navigationTitle("Book details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    
                } label: {
                    ZStack{
                        Image(systemName: "cart")
                        if appVM.myCart.count > 0 {
                            BadgeView(quantity: appVM.myCart.count)
                        }
                    }
                    
                        //.font(.title)
                }
            }
        }
        .zIndex(0)
        //.ignoresSafeArea(.all, edges: .all)
        .background {
            Color.myBackgroundColor.ignoresSafeArea(.all, edges: .all)
        }
    }
}



struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NavigationStack {
                BookDetailView(vm: RowVM(book: .preview))
                    .environmentObject(BooksViewModel(.inPreview))
            }
            .tabItem {
                Label("Books", systemImage: "books")
            }.tag(0)
        }
        
    }
}
