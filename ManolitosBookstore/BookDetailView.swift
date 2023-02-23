//
//  BookDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookDetailView: View {
//    d@EnvironmentObject var appVM: BooksViewModel
    @ObservedObject var vm: BookDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State var ratingDetent = false
    @State var isEditing = false
    
    
    var body: some View {
        ScrollView {
                VStack{
                    GeometryReader { g in
                    VStack (alignment: .center, spacing: 20) {
                        VStack {
                            if let coverURL = vm.book.cover {
                                AsyncImage(url: coverURL) { image in //318x384
                                    image.resizable()
                                        .scaledToFill()
                                        
                                    //.clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .frame(alignment: .center)
                                }
                            } else {
                                Image(systemName: "book")
                                    .font(.largeTitle)
                                    .frame(alignment: .center)
                            }
                        }
//                        .frame(width: (g.size.width)/4, alignment: .leading)

                        Text("\(vm.book.title)")
                            .font(.title)
                        
                        VStack (alignment: .leading) {

//                            Text("Author: **\(vm.book.author ?? "")**")
                            //.font(.footnote).foregroundColor(.gray)
                            if let bookYear = vm.book.year  {
                                Text("Year: **\(bookYear, specifier: "%.0d")**")
                                // .font(.footnote).foregroundColor(.gray)
                            } else {
                                Text("Year: - ")
                            }
                        }
//                        .frame(width: g.size.width*3/4, alignment: .leading)
                        VStack (alignment: .leading) {
                            Text("**Summary**")
                            Text("\(vm.book.summary ?? "")")
                                .lineLimit(nil)
                            
                        }
                        
                    }
                    
                    
                }
                
            }
                .padding()
            //        .navigationTitle("\(vm.book.title)")
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookDetailView(vm: BookDetailViewModel(book: .preview))
            //            .environmentObject()
        }
    }
}
