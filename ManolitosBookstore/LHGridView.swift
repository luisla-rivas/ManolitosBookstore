//
//  LHGridView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 10/2/23.
//

import SwiftUI

struct LHGridView: View {
    let books:Books
    var body: some View {
        Group {
            ScrollView(.horizontal) {
                //LazyVGrid(columns: [GridItem(.adaptive(minimum: 250,maximum: 350))]) {
                LazyHGrid(rows: [GridItem(.fixed(300))], alignment: .center, spacing: 4) { //>iOS14
                    ForEach(books) { book in //, id:\.self
                        NavigationLink(value: book) {
                            VStack(alignment: .center) {
                                if book.cover != nil, let coverURL = URL(string: book.cover!) {
                                    AsyncImage(url: coverURL) { image in //318x384
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(height: 250, alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(height: 250, alignment: .center)
                                    }
                                } else {
                                    Image(systemName: "book")
                                        .font(.custom("AvernirNext", size: 100))
                                        .frame(height: 250, alignment: .center)
                                }
                                Text("**\(book.title)**").foregroundColor(.black)
                                    .truncationMode(.tail)
                                    .lineLimit(2, reservesSpace: true) //
                                    .fontWeight(.bold)
                                //.font(.headline)
                                VStack(alignment:.leading) {

                                    Text("Author: **\(book.author ?? "")**")
                                        
                                        .font(.footnote).foregroundColor(.gray)
                                    if let bookYear = book.year  {
                                        Text("Year: **\(bookYear, specifier: "%.0d")**")
                                            .font(.footnote).foregroundColor(.gray)
                                    } else {
                                        Text("Year: - ")
                                    }
                                }.padding([.leading, .trailing, .bottom])
                            }
                            .padding(.top)
                            .frame(width: 200, alignment: .top)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color(uiColor:.quaternarySystemFill))
                                }
                        }
                    }
                }
            }
        }
    }
}

struct LHGridView_Previews: PreviewProvider {
    static var previews: some View {
        LHGridView(books: BooksViewModel(option: .inPreview).books)
    }
}
