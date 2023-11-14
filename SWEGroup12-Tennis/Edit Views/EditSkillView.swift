//
//  EditSkillView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/31/23.
//
import SwiftUI

struct EditSkillView: View {

    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var isSelected3 = false

    var body: some View {
        VStack {
            Text("Skill Level")
                .font(.headline)
                .padding(.bottom, 30)

            VStack{
                HStack(spacing: 50){
                    SelectButton(isSelected: $isSelected, color:CustomColor.myColor)
                        .onTapGesture{
                            isSelected.toggle()
                            isSelected2 = false
                            isSelected3 = false
                            viewModel.change = "Beginner"
                        }

                    SelectButton(isSelected: $isSelected2, color:CustomColor.myColor)
                        .onTapGesture{
                            isSelected2.toggle()
                            isSelected = false
                            isSelected3 = false
                           viewModel.change = "Club"
                        }

                    SelectButton(isSelected: $isSelected3, color:CustomColor.myColor)
                        .onTapGesture{
                            isSelected3.toggle()
                            isSelected2 = false
                            isSelected = false
                            viewModel.change = "College"
                        }
                }

                HStack(spacing: 16){
                    Text("Beginner")
                    Text("Club")
                    Text("College")
                }


            }
            .frame(width:300, height:100)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .padding(.bottom, 20)

            Button{
                Task{
                    viewModel.changeCategory = "skillLevel"
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

extension EditSkillView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return (isSelected || isSelected2 || isSelected3)
    }
}

#Preview {
    EditSkillView()
}
