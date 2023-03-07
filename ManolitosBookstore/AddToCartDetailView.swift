//
//  AddToCartDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 4/3/23.
//

import SwiftUI

struct AddToCartDetailView: View {
  // MARK: - PROPERTY
  
//  @EnvironmentObject var shop: Shop
  
  // MARK: - BODY
  
  var body: some View {
    Button {
//      feedback.impactOccurred()
    } label: {
      //Spacer()
      Text("Add to cart".uppercased())
        .font(.system(.title2, design: .rounded))
        .fontWeight(.bold)
        .foregroundColor(.white)
      //Spacer()
    } //: BUTTON
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
    .background {
        Color.myBackgroundColor
    }
    .clipShape(Capsule())
  }
}

// MARK: - PREVIEW

struct AddToCartDetailView_Previews: PreviewProvider {
  static var previews: some View {
    AddToCartDetailView()
//      .environmentObject(Shop())
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
