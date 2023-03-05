//
//  RatingView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 4/3/23.
//

import SwiftUI

struct RatingView: View {
    var rating: CGFloat
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

struct RatingView_Previews: PreviewProvider {
static var previews: some View {
    RatingView(rating: 3.5 , maxRating: 5)
        .frame(width: 375,height: 150)
        .previewLayout(.sizeThatFits)
}
}
