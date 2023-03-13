//
//  CollapsibleSection.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 11/3/23.
//

import SwiftUI


struct MyView: View {
    
    var body: some View {
        VStack {
            CollapsibleSection(title: "Vehicles") { // @ViewBuilder at work here
                Text("Millennium Falcon")
                Text("AT-AT")
                Text("Landspeeder")
                Text("TIE Fighter")
                Text("Slave I")
                Text("AT-ST")
                Text("X-Wing")
                Text("Dreadnought")
            }
            CollapsibleSection(title: "More Vehicles") { // @ViewBuilder at work here
                Text("Millennium Falcon")
                Text("AT-AT")
                Text("Landspeeder")
                Text("TIE Fighter")
                Text("Slave I")
                Text("AT-ST")
                Text("X-Wing")
                Text("Dreadnought")
            }
            Spacer()
        }
        
    }
}


struct CollapsibleSection<Content: View>: View {

    private let title: String
    private let content: Content
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat
    @State private var isExpanded = false

    init(title: String, alignment: HorizontalAlignment = .leading, spacing: CGFloat = 16, @ViewBuilder content: () -> Content) {
        self.title = title
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        Section {
            if isExpanded {
                VStack(alignment: alignment, spacing: spacing) {
                    content
                }
            }
        } header: {
            HStack {
                Image(systemName: "chevron.right")//.padding(.horizontal)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                Text(title)
                    .font(.custom("Avenir Next Condensed", size: 24))
                    .padding(.horizontal)
                Spacer()
                    
            }
            .padding(.leading)
            .padding(.vertical, 5)
            .foregroundColor(Color(uiColor: .systemBackground))
            .background(Color.myBackgroundColor)
            .cornerRadius(10)
            .onTapGesture {
                withAnimation { isExpanded.toggle() }
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
