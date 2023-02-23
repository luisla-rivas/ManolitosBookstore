//
//  BookRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 9/2/23.
//

import SwiftUI

struct BookRowView: View {
//    @EnvironmentObject var appVM:BooksViewModel
    let rowVM:RowVM
    var body: some View {
        HStack(alignment: .center) {
            if let coverURL = rowVM.book.cover {
                AsyncImage(url: coverURL) { image in //318x384
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 120, alignment: .leading)
                    //.clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 70, height: 120, alignment: .center)
                }
            } else {
                Image(systemName: "book")
                    .font(.largeTitle)
                    .frame(width: 70, height: 120, alignment: .center)
            }
            
            
            VStack (alignment: .leading, spacing: 5) {
                Text("Title: **\(rowVM.title)**")
                    //.font(.headline)
                Text("Author: **\(rowVM.authorName)**")
                    //.font(.footnote).foregroundColor(.gray)
                Text("Year: **\(rowVM.year)**")
//                    Text("Year: **\(bookYear, specifier: "%.0d")**")
                       // .font(.footnote).foregroundColor(.gray)

            }
            Spacer()
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(rowVM: RowVM(book: .preview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)

    }
}

