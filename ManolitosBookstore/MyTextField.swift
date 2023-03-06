//
//  MyTextField.swift
//  ManolitosBookstore
//
//  Created on 6/3/23.
//

import SwiftUI

struct MyTextField: View {
    let label:String
    @Binding var text:String
    var validation:((String) -> String?)?
    
    @State var error = false
    @State var errorMsg = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
            HStack {
                TextField("Enter the \(label.lowercased())", text: $text)
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark")
                            .symbolVariant(.circle)
                            .symbolVariant(.fill)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .opacity(0.5)
                }
            }
            .padding(2)
            .background {
                Rectangle()
                    .stroke(lineWidth: 2)
                    .fill(.red)
                    .opacity(error ? 1.0 : 0.0)
            }
            .onChange(of: text) { newValue in
                if let validation, let message = validation(newValue) {
                    errorMsg = message.replacingOccurrences(of: "%@", with: label.capitalized)
                    error = true
                } else {
                    error = false
                }
            }
            if error {
                Text(errorMsg)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

struct MyTextField_Previews: PreviewProvider {
    static var previews: some View {
        MyTextField(label: "First name", text: .constant("Luis"))
    }
}

