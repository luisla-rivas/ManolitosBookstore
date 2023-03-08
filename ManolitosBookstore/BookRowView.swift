//
//  BookRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 9/2/23.
//

import SwiftUI

struct BookRowView: View {
    @EnvironmentObject var appVM:BooksViewModel
    let vm:RowVM
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            if vm.book.cover != nil{
                if let image = vm.cover {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 120, alignment: .leading)
                } else {
                    ProgressView()
                        .frame(width: 70, height: 120, alignment: .center)
                }
//            if let coverURL = vm.book.cover {
//                AsyncImage(url: coverURL) { image in //318x384
//                    image.resizable()
//                        .scaledToFit()
//                        .frame(width: 70, height: 120, alignment: .leading)
//                        .onAppear {
//                            vm.cover = image
//                        }
//                    //.clipShape(Circle())
//                } placeholder: {
//                    ProgressView()
//                        .frame(width: 70, height: 120, alignment: .center)
//                }
            } else {
                Image(systemName: "book")
                    .font(.largeTitle)
                    .frame(width: 70, height: 120, alignment: .center)
            }
            
            
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text("Title: **\(vm.title)**")
                    Spacer()
                    if appVM.iHaveReaded(idAPI: vm.book.idAPI) {
                        Image(systemName: "bookmark").foregroundColor(.blue)
                    }
                }
                //.font(.headline)
                Text("Author: **\(vm.authorName)**")
                //.font(.footnote).foregroundColor(.gray)
                HStack {
                    Text("Year: **\(vm.year)**")
                    Spacer()
                    Text("Price: **\(vm.book.price.inEuro)**")
   
                }
                
                //2.1 Rating
                HStack(alignment: .bottom) {
                    Text("Rating:")
                    Spacer()
                    RatingView(rating: vm.book.rating ?? 0.0, maxRating: 5)
                        .frame(maxWidth: 80).offset(y: -2)

                    Text("(\(Double(vm.book.rating ?? 0.0).formatted(.number.precision(.fractionLength(2)))) /5.0)")



//                    Text(vm.book.price.inEuro)
//                        //.font(.caption)
//                        .padding(.horizontal)
//                        .padding(.vertical, 5)
//                        .background {
//                            RoundedRectangle(cornerRadius: 5, style: .continuous)
//                                .fill(Color.myPriceColor)
//
//                        }
                }
                
            }
            Spacer()
        }
//        .padding()
//            .background{
//            Color(uiColor: .quaternaryLabel)
//        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(vm: RowVM(book: .preview))
            .environmentObject(BooksViewModel(.inPreview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)

    }
}

