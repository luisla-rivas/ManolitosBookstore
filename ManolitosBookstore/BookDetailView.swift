//
//  BookDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct BookDetailView: View {
//    d@EnvironmentObject var appVM: BooksViewModel
    @ObservedObject var detailVM: BookDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State var ratingDetent = false
    @State var isEditing = false
    
    
    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(detailVM: BookDetailViewModel(book: .preview))
//            .environmentObject()
    }
}
