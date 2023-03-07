//
//  HeaderDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 3/3/23.
//

import SwiftUI

struct HeaderDetailView: View {
    // MARK: - PROPERTY
    
    @ObservedObject var vm: RowVM
    
    // MARK: - BODY
    
    var body: some View {
      VStack(alignment: .leading, spacing: 6) {
          Text(vm.authorName)
          Text(vm.title)
          .font(.largeTitle)
          .fontWeight(.black)
      }
      .foregroundColor(.white)
    }
  }

  // MARK: - PREVIEW

  struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailView(vm: RowVM(book: Book.preview))
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray)
    }
  }
