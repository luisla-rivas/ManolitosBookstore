//
//  HeaderDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 3/3/23.
//

import SwiftUI

struct HeaderDetailView: View {
    // MARK: - PROPERTY
    
    let title: String
    
    // MARK: - BODY
    
    var body: some View {
      VStack(alignment: .leading, spacing: 6) {
        Text("Classical Fantastic Books")
        Text(title)
          .font(.largeTitle)
          .fontWeight(.black)
      }
      .foregroundColor(.white)
    }
  }

  // MARK: - PREVIEW

  struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailView(title: Book.preview.title)
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray)
    }
  }
