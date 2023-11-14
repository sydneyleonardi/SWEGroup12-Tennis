//
//  EditProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/19/23.
//
// Add In Profile Picture

import SwiftUI

struct EditProfileView: View {

    @State private var showAlert = false
    @State private var alertText = ""

    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {

        VStack{
            Text("Edit Profile")
                .font(.headline)
                .padding(.bottom, 20)

            ScrollView{
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .padding(.vertical, 10)

                    NavigationLink{

                    }label:{
                        Text("Edit Picture")
                            .font(.subheadline)

                    }
                    .padding(.bottom, 20)
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Name")
                            .bold()
                            .font(.subheadline)

                        NavigationLink{
                            CustomEditView(title: "Name", textField: "New Name", category: "name", old: viewModel.user?.name ?? "")
                        }label:{
                            Text(viewModel.user?.name ?? "")
                                .frame(width: 300, height: 50, alignment: .leading)
                                .padding(.leading, 15)
                                .foregroundColor(.black)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)

                        Text("Gender")
                            .bold()
                            .font(.subheadline)

                        NavigationLink{
                            CustomEditView(title: "Gender", textField: "New Gender", category: "gender", old: viewModel.user?.gender ?? "")
                        }label:{
                            Text(viewModel.user?.gender ?? "")
                                .frame(width: 300, height: 50, alignment: .leading)
                                .padding(.leading, 15)
                                .foregroundColor(.black)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)

                        Text("Age")
                            .bold()
                            .font(.subheadline)

                        NavigationLink{
                            CustomEditView(title: "Age", textField: "New Age", category: "age", old: viewModel.user?.age ?? "")
                        }label:{
                            Text(viewModel.user?.age ?? "")
                                .frame(width: 300, height: 50, alignment: .leading)
                                .padding(.leading, 15)
                                .foregroundColor(.black)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)

                        Text("About")
                            .bold()
                            .font(.subheadline)

                        NavigationLink{
                            CustomEditView(title: "About", textField: "About You", category: "description", old: viewModel.user?.description ?? "")
                        }label:{
                            Text(viewModel.user?.description ?? "")
                                .frame(width: 315, height: 75, alignment: .leading)
                                .padding(.leading, 15)
                                .foregroundColor(.black)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)

                        Text("Skill Level")
                            .bold()
                            .font(.subheadline)
                            .padding(.bottom, 10)

                        NavigationLink{
                           EditSkillView()
                        }label:{
                            VStack{
                                HStack(spacing: 50){
                                    SelectButton(isSelected: $viewModel.isSelected, color:CustomColor.myColor)

                                    SelectButton(isSelected: $viewModel.isSelected2, color:CustomColor.myColor)

                                    SelectButton(isSelected: $viewModel.isSelected3, color:CustomColor.myColor)
                                }
                                .padding(.top, 10)

                                HStack(spacing: 18){
                                    Text("Beginner")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    Text("Club")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    Text("College")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width:315, height:75)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        }
                        .padding(.bottom, 10)

                        Text("Play Type")
                            .bold()
                            .font(.subheadline)
                            .padding(.bottom, 10)

                        NavigationLink{
                            EditPlayView()
                        }label:{
                            VStack{
                                HStack(spacing: 50){
                                    SelectButton(isSelected: $viewModel.isSelected4, color:CustomColor.myColor)

                                    SelectButton(isSelected: $viewModel.isSelected5, color:CustomColor.myColor)

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
                            .padding(.bottom, 10)
                        }

                        Text("Availability")
                            .bold()
                            .font(.subheadline)
                            .padding(.bottom, 10)

                        NavigationLink{
                            EditAvailabilityView()
                        }label:{
                            VStack{

                                HStack{
                                    Text("Morning")
                                        .padding(.leading, 20)
                                        .offset(x: 20)
                                        .foregroundColor(.black)
                                    Text("Afternoon")
                                        .padding(.leading, 10)
                                        .offset(x:25)
                                        .foregroundColor(.black)
                                    Text("Evening")
                                        .padding(.leading, 10)
                                        .offset(x:30)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 30)

                                HStack(spacing: 5){
                                    Text("(8am-12pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 20)
                                        .offset(x: 20)
                                        .foregroundColor(.black)
                                    Text("(12pm-4pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 10)
                                        .offset(x:20)
                                        .foregroundColor(.black)
                                    Text("(4pm-8pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 10)
                                        .offset(x:30)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 30)

                                HStack(spacing: 60){
                                    VStack(alignment: .leading, spacing:1){
                                        Text("M")
                                            .padding(.bottom, 4)
                                            .foregroundColor(.black)
                                        Text("Tu")
                                            .padding(.bottom, 4)
                                            .foregroundColor(.black)
                                        Text("W")
                                            .padding(.bottom, 4)
                                            .foregroundColor(.black)
                                        Text("T")
                                            .padding(.bottom, 4)
                                            .foregroundColor(.black)
                                        Text("F")
                                            .foregroundColor(.black)
                                        }
                                    VStack{
                                        SelectButton(isSelected: $viewModel.isSelected6 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected7 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected8 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected9 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected10 , color: CustomColor.myColor)

                                    }
                                    .offset(x:-20)

                                    VStack{
                                        SelectButton(isSelected: $viewModel.isSelected11 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected12 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected13 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected14 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected15 , color: CustomColor.myColor)
                                    }
                                    .offset(x:-10)

                                    VStack{
                                        SelectButton(isSelected: $viewModel.isSelected16 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected17 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected18 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected19 , color: CustomColor.myColor)

                                        SelectButton(isSelected: $viewModel.isSelected20 , color: CustomColor.myColor)
                                    }
                                    .offset(x:10)
                                }
                                .padding(.trailing, 20)
                            }
                            .frame(width:315, height:225)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.leading, 40)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            Task{
                try? await viewModel.loadCurrentUser()
            }
        }
    }
}

#Preview {
    EditProfileView()
}
