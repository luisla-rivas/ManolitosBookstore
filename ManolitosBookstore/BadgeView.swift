//
//  BadgeView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 9/3/23.
//

import SwiftUI

struct BadgeView: View {
    var quantity: Int
    var body: some View {
        Text("\(quantity)")
            .font(.caption).foregroundColor(Color(uiColor: .systemBackground))
            .padding(5)
            .background {
                Circle().fill(Color.red)
            }.offset(x: 11, y: -11)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(quantity: 2)
    }
}
