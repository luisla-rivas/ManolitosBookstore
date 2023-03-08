//
//  TopPartDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 3/3/23.
//

import SwiftUI

struct TopPartDetailView: View {
    // MARK: - PROPERTY
    
    @ObservedObject var vm: RowVM
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 6){
                // PRICE
                VStack(alignment: .leading, spacing: 6) {
                    Text("Price")
                        .fontWeight(.semibold)
                    
                    Text(vm.price) //"\(price.formatted(.number.precision(.fractionLength(2))))€"
                        .font(.title)
                        .fontWeight(.black)
                        .scaleEffect(1.25, anchor: .leading)
                        .zIndex(2)
                }
                .offset(y: isAnimating ? -50 : -75)
                
                Spacer()
            }
            .zIndex(2)
            // PHOTO
            HStack{
                Spacer()
                if vm.book.cover != nil{
                    if let image = vm.cover {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250, maxHeight:300, alignment: .trailing)
                            .shadow(radius: 4, x: -3, y: 3)
                            .offset(y: isAnimating ? 0 : -35)
                    } else {
                        ProgressView()
                            .frame(width: 250, height: 250, alignment: .center)
                    }
                } else {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250, maxHeight:300, alignment: .trailing)
                        .shadow(radius: 4, x: -3, y: 3)
                        .offset(y: isAnimating ? 0 : -35)
                }
            }
        }
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
        TopPartDetailView(vm: RowVM(book: .preview))
//            .previewLayout(.sizeThatFits)
            .padding()
    }
}
