//
//  OrderDetailView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 23/2/23.
//

import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject var appVM:BooksViewModel
    @ObservedObject var vm:ORowVM
    @Environment(\.dismiss) var dismiss
    
    @State var activateFlor = false
    
    var body: some View {
        ZStack {
            HStack {
                Color.myBackgroundColor.frame(width: 8)
                Spacer()
                VStack(alignment: .leading) {

                    Picker ("State: ", selection: $vm.selectedState) {
                        ForEach(OrderState.allCases, id:\.self) { state in
                            Text(state.rawValue)
                        }
                    }.pickerStyle(.automatic)
 
                    HStack {
                        Text("Order Date:")
                        Spacer()
                        Text(vm.order.date.formatted(date: .abbreviated, time: .omitted))
                        
                    }
                    HStack {
                        Text("Customer:")
                        Spacer()
                        Text(vm.order.email).font(.custom("Avenir Next Condensed", size: 20))
                    }
                    Divider()
                    
                    OrderedBookListView(books: appVM.booksWith(idsAPI: vm.order.books))
                        .padding()
                    Spacer()
                }
            }
            if activateFlor {
                HStack{
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
            }
        }
        .onChange(of: vm.selectedState) { new in
            activateFlor.toggle()
            appVM.tryModifyStateTo(new, for: vm.order.id)
        }
        .padding()
        .navigationTitle("Purchase Order Detail")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Perfect!",
               isPresented: $appVM.showError) {
            Button {
                activateFlor.toggle()
                appVM.errorMsg = ""
                dismiss()
            } label: {
                Text("OK")
            }
        } message: {
            Text(appVM.errorMsg)
        }

    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrderDetailView(vm: ORowVM(order: .preview))
                .environmentObject(BooksViewModel(.inPreview))
        }
    }
}

//if appVM.currentUser?.role == .client {
//    HStack {
//        Text(vm.order.date.formatted(date: .abbreviated, time: .omitted))
//            .bold()
//        Spacer()
//        Text("State: **\(vm.state.rawValue.capitalized)**")
//
//    }
//} else {

//
//}
