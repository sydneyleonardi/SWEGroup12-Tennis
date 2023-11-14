//
//  EditPlayView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/31/23.
//
import SwiftUI

struct EditPlayView: View {

    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isSelected4 = false
    @State private var isSelected5 = false


    var body: some View {
        VStack{
            Text("Play Type")
                .font(.headline)
                .padding(.bottom, 30)

            VStack{
                HStack(spacing: 50){
                    SelectButton(isSelected: $isSelected4, color:CustomColor.myColor)
                        .onTapGesture{
                            isSelected4.toggle()
                            isSelected5 = false
                            viewModel.change = "Singles"
                        }

                    SelectButton(isSelected: $isSelected5, color:CustomColor.myColor).onTapGesture{
                        isSelected5.toggle()
                        isSelected4 = false
                        viewModel.change = "Doubles"
                    }

                }
                .padding(.top, 10)

                HStack(spacing: 18){
                    Text("Singles")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Text("Doubles")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 10)
            }
            .frame(width:315, height:75)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .padding(.bottom, 20)

            Button{
                Task{
                    viewModel.changeCategory = "type"
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

            Spacer()
        }
    }
}

extension EditPlayView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return (isSelected4 || isSelected5)
    }
}


#Preview {
    EditPlayView()
}
