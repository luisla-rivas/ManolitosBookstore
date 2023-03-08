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
                        Text("Rating").bold().frame(width: .infinity)
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
            
                QuantityAndReadedDetailView(vm: vm)
                    .padding(.vertical, 10)
                
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
        .navigationTitle("Book details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    Menu("Sort") {
            //                        ForEach(ScoresViewModel.SortType.allCases, id:\.self) { opcion in
            //                            Button {
            //                                scoresVM.sortType = opcion
            //                            } label: {
            //                                Text(opcion.rawValue)
            //                            }
            //                        }
            //                    }
            //                }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    
                } label: {
                    Image(systemName: "cart")
                        .badge("1")
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
                .environmentObject(BooksViewModel(.inPreview))
        }
    }
}
