//
//  CustomInputField.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    var title: String
    var placeholder: String
    var isSecured: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecured {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            Rectangle()
                .foregroundColor(Color(.init(white: 1.0, alpha: 0.3)))
                .frame(height: 0.7)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(text: .constant(""), title: "Email", placeholder: "Enter your email address")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
