//
//  TopPartDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 3/3/23.
//

import SwiftUI

struct TopPartDetailView: View {
    // MARK: - PROPERTY
    
    var price: String
    var image: Image
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
      HStack(alignment: .center, spacing: 6, content: {
        // PRICE
        VStack(alignment: .leading, spacing: 6) {
          Text("Price")
            .fontWeight(.semibold)

            Text(price) //"\(price.formatted(.number.precision(.fractionLength(2))))€"
            .font(.title)
            .fontWeight(.black)
            .scaleEffect(1.35, anchor: .leading)
        }
        .offset(y: isAnimating ? -50 : -75)
        
        Spacer()
        
        // PHOTO
        image
          .resizable()
          .scaledToFit()
          .frame(maxHeight:300)
          .shadow(radius: 4, x: -3, y: 3)
          .offset(y: isAnimating ? 0 : -35)
      }) //: HSTACK
      .onAppear {
        withAnimation(.easeOut(duration: 0.75)) {
          isAnimating.toggle()
        }
      }
    }
  }

  // MARK: - BODY

  struct TopPartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TopPartDetailView(price: Book.preview.price.inEuro, image: Image("theTimeMachine"))
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
