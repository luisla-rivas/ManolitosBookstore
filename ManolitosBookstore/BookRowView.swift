//
//  BookRowView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 9/2/23.
//

import SwiftUI

struct BookRowView: View {
    let book:Book
    var body: some View {
        HStack(alignment: .center) {
            if book.cover != nil, let coverURL = URL(string: book.cover!) {
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
            
            
            VStack (alignment: .leading) {
                Text("Title: **\(book.title)**")
                    //.font(.headline)
                Text("Author: **\(book.author ?? "")**")
                    //.font(.footnote).foregroundColor(.gray)
                if let bookYear = book.year  {
                    Text("Year: **\(bookYear, specifier: "%.0d")**")
                       // .font(.footnote).foregroundColor(.gray)
                } else {
                    Text("Year: - ")
                }
            }
            Spacer()
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: .preview)

    }
}


