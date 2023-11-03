//
//  CustomEditView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/31/23.
//

import SwiftUI

struct CustomEditView: View {
    
    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    let title: String
    let textField: String
    let category: String
    let old: String
    
    var body: some View {
        VStack{
            Text(title)
                .font(.headline)
                .padding(.bottom, 30)
            
            InputView(text: $viewModel.change, title: textField)
                .padding(.bottom, 20)
            
            Button{
                Task{
                    viewModel.changeCategory = category
                    try await viewModel.editUserProfile()
                    dismiss()
                }
            }label: {
                Text("Save")
            }
            .padding(30)
            .frame(width:300, height:50)
            .background(CustomColor.myColor)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .cornerRadius(10)
            .foregroundColor(.black)
        }
        
        Spacer()
    }
}

extension CustomEditView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.change.isEmpty
        && viewModel.change != old
    }
}

#Preview {
    CustomEditView(title: "", textField: "", category: "", old: "")
}
