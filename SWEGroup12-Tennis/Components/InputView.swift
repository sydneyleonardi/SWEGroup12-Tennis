//
//  InputView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/10/23.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    var body: some View {
        VStack(spacing: 12){

            if isSecureField{
                SecureField(title, text: $text)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .font(.system(size: 14))
            }else{
                TextField(title, text: $text)
                    .font(.system(size: 14))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
            }
            
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Vanderbilt Email")
}
