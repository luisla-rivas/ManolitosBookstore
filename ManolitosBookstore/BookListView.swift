//
//  BookListView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var appVM:BooksViewModel
    //@State var path:[Int] = []
    let books: Books
    var body: some View {
        ForEach(books) { book in 
            NavigationLink(value: book) {
                BookRowView(vm: RowVM(book: book))
                    .frame(alignment: .leading )
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            appVM.toggleReaded(idsAPI:[book.idAPI])
                        } label: {
                            Image(systemName: "bookmark.slash.fill")
                            if !appVM.iHaveReaded(idAPI: book.idAPI) {
                                Label("Readed", systemImage: "bookmark.fill")
                            } else {
                                Label("Not Readed", systemImage: "bookmark.slash.fill")
                            }
                        }
                        .tint(appVM.iHaveReaded(idAPI: book.idAPI) ? .red : .blue)
                    }
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(books: BooksViewModel(.inPreview).books)
    }
}

//struct LatestBooksView: View {
//    let book:Book
//    var body: some View {
//        HStack(alignment: .center) {
//            if book.cover != nil, let coverURL = URL(string: book.cover!) {
//                AsyncImage(url: coverURL) { image in //318x384
//                    image.resizable()
//                        .scaledToFit()
//                        .frame(width: 70, height: 120, alignment: .leading)
//                    //.clipShape(Circle())
//                } placeholder: {
//                    ProgressView()
//                        .frame(width: 70, height: 120, alignment: .center)
//                }
//            } else {
//                Image(systemName: "book")
//                    .font(.largeTitle)
//                    .frame(width: 70, height: 120, alignment: .center)
//            }
//            
//            
//            VStack (alignment: .leading) {
//                Text(book.title).font(.headline)
//                Text("Author: \(book.author ?? "")")
//                    .font(.caption).foregroundColor(.gray)
//                if let bookYear = book.year  {
//                    Text("Year: \(bookYear, specifier: "%.0d")")
//                        .font(.footnote).foregroundColor(.gray)
//                } else {
//                    Text("Year: - ")
//                }
//            }
//            Spacer()
//        }
//    }
//}


