//
//  BookDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookDetailView: View {
//    d@EnvironmentObject var appVM: BooksViewModel
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
            
            // HEADER
            HeaderDetailView(vm: vm)
                .padding(.horizontal)
            
            // DETAIL TOP PART
            TopPartDetailView(vm: vm)
                .padding(.horizontal)
                .zIndex(1)
            
            // DETAIL BOTTOM PART
            VStack(alignment: .center, spacing: 0) {
                 //RATINGS + SIZES
                
                HStack {
                    RatingView(rating: vm.book.rating ?? 0.0, maxRating: 5).frame(maxWidth: 100)
                        .padding(.top, -40)
                    .padding(.bottom, 10)
                    Spacer()
                }
                
                // DESCRIPTION
                ScrollView(.vertical, showsIndicators: false){
                    Text(vm.book.summary ?? "")
                        .font(.system(.body, design: .rounded))
                    //                        .foregroundColor(.gray)
                    //                        .multilineTextAlignment(.leading)
                }
                
                // QUANTITY + FAVOURITE
                //                        QuantityFavouriteDetailView()
                //                            .padding(.vertical, 10)
                
                // ADD TO CART
                AddToCartDetailView()
                    .padding(.vertical, 10)
            }
            .padding()//(.horizontal)
            .background {
                Color.white
                    .clipShape(CustomShape())
                    .padding(.top, -85)
            }
//            Spacer()
        }
        .zIndex(0)
        //.ignoresSafeArea(.all, edges: .all)
        .background {
            Color.myBackgroundColor.ignoresSafeArea(.all, edges: .all)
        }
    }

//        ScrollView {
//                VStack{
//                    GeometryReader { g in
//                    VStack (alignment: .center, spacing: 20) {
//                        VStack {
//                            if let coverURL = vm.book.cover {
//                                AsyncImage(url: coverURL) { image in //318x384
//                                    image.resizable()
//                                        .scaledToFill()
//
//                                    //.clipShape(Circle())
//                                } placeholder: {
//                                    ProgressView()
//                                        .frame(alignment: .center)
//                                }
//                            } else {
//                                Image(systemName: "book")
//                                    .font(.largeTitle)
//                                    .frame(alignment: .center)
//                            }
//                        }
////                        .frame(width: (g.size.width)/4, alignment: .leading)
//
//                        Text("\(vm.book.title)")
//                            .font(.title)
//
//                        VStack (alignment: .leading) {
//
////                            Text("Author: **\(vm.book.author ?? "")**")
//                            //.font(.footnote).foregroundColor(.gray)
//                            if let bookYear = vm.book.year  {
//                                Text("Year: **\(bookYear, specifier: "%.0d")**")
//                                // .font(.footnote).foregroundColor(.gray)
//                            } else {
//                                Text("Year: - ")
//                            }
//                        }
////                        .frame(width: g.size.width*3/4, alignment: .leading)
//                        VStack (alignment: .leading) {
//                            Text("**Summary**")
//                            Text("\(vm.book.summary ?? "")")
//                                .lineLimit(nil)
//
//                        }
//
//                    }
//
//
//                }
//
//            }
//                .padding()
//            //        .navigationTitle("\(vm.book.title)")
//        }
//    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookDetailView(vm: RowVM(book: .preview))
            //            .environmentObject()
        }
    }
}
