//
//  BookGridView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct BookGridView: View {
    let rowVM:RowVM
    var body: some View {
        VStack(alignment: .center) {
            if let coverURL = rowVM.book.cover  {
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
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .frame(height: 250, alignment: .center)
            }
            Text("**\(rowVM.title)**").foregroundColor(Color(uiColor: .label))
                .truncationMode(.tail)
                .lineLimit(2, reservesSpace: true) //
                .fontWeight(.bold)
            //.font(.headline)
            VStack(alignment:.leading) {

                Text("Author: **\(rowVM.authorName)**")
                    .font(.footnote).foregroundColor(.gray)
                
                Text("Year: **\(rowVM.year)**")
                    .font(.footnote).foregroundColor(.gray)
          
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

struct BookGridView_Previews: PreviewProvider {
    static var previews: some View {
        BookGridView(rowVM: RowVM(book: .preview))
            .padding()
            .previewLayout(.sizeThatFits)
            .frame(width: 400,height: 150)
    }
}
