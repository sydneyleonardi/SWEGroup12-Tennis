//
//  ProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// Add Profile Image
// Potentially adjust how many words are allowed in each category
// Potentially get rid of scroll vie w

import SwiftUI
import SDWebImageSwiftUI

extension Color {
    static let darkGray = Color(UIColor.darkGray)
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    
    var body: some View {
        let user = viewModel.user
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .font(.headline)
                            .foregroundColor(Color.darkGray)
                    }
                    .padding(.trailing, 20)
                }
                
                ScrollView{
                    VStack(alignment: .leading){
                        HStack{
                            if(user?.profileImageURL != "")
                            {
                                WebImage(url: URL(string: user?.profileImageURL ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 2))
                                    .clipped()
                                    .cornerRadius(50)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 20)
                                    .foregroundColor(CustomColor.myColor)
                            } else{
                                Image("person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 2))
                                    .clipped()
                                    .cornerRadius(50)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 20)
                                    .foregroundColor(CustomColor.myColor)
                            }
                            VStack(alignment: .leading){
                                // User name
                                Text(user?.name ?? "")
                                    .font(.title)
                                    .padding(.top, 20)
                                
                                // User gender
                                Text(user?.gender ?? "")
                                    .font(.subheadline)
                                
                                // User age
                                Text(user?.age ?? "")
                                    .font(.subheadline)
                                    .padding(.bottom, 20)
                            }
                            Spacer()
                        }
                        .padding(.leading, 40)
                    }
                    
                    VStack(alignment: .leading){
                        
                        // Navigates to Edit Profile Page
                        NavigationLink{
                            EditProfileView()
                        }label:
                        {
                            Text("Edit Profile")
                                .foregroundColor(.black)
                        }
                        .frame(width: 300, height: 25)
                        .background(CustomColor.myColor)
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                        
                        // User description
                        Text("About")
                            .bold()
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        Text(user?.description ?? "")
                            .font(.subheadline)
                            .padding(.bottom, 10)
                            .frame(width: 300)
                        
                        
                        // User Skill Level
                        Text("Skill Level")
                            .bold()
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        VStack{
                            HStack(spacing: 50){
                                SelectButton(isSelected: $viewModel.isSelected, color:CustomColor.myColor)
                                
                                SelectButton(isSelected: $viewModel.isSelected2, color:CustomColor.myColor)
                                
                                SelectButton(isSelected: $viewModel.isSelected3, color:CustomColor.myColor)
                            }
                            
                            HStack(spacing: 18){
                                Text("Beginner")
                                    .font(.subheadline)
                                Text("Club")
                                    .font(.subheadline)
                                Text("College")
                                    .font(.subheadline)
                            }
                            .padding(.bottom, 10)
                        }
                        
                        // User Play Type
                        Text("Looking to Play")
                            .bold()
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        VStack{
                            HStack(spacing: 50){
                                SelectButton(isSelected: $viewModel.isSelected4, color:CustomColor.myColor)
                                
                                SelectButton(isSelected: $viewModel.isSelected5, color:CustomColor.myColor)
                                
                            }
                            
                            HStack(spacing: 18){
                                Text("Singles")
                                    .font(.subheadline)
                                Text("Doubles")
                                    .font(.subheadline)
                            }
                            .padding(.bottom, 10)
                        }
                        
                        // User Availability
                        Text("Availability")
                            .bold()
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        VStack{
                            
                            HStack{
                                Text("Morning")
                                    .padding(.leading, 20)
                                    .offset(x: 20)
                                Text("Afternoon")
                                    .padding(.leading, 10)
                                    .offset(x:25)
                                Text("Evening")
                                    .padding(.leading, 10)
                                    .offset(x:30)
                            }
                            
                            HStack(spacing: 5){
                                Text("(8am-12pm)")
                                    .font(.system(size:12))
                                    .padding(.leading, 20)
                                    .offset(x: 20)
                                Text("(12pm-4pm)")
                                    .font(.system(size:12))
                                    .padding(.leading, 10)
                                    .offset(x:20)
                                Text("(4pm-8pm)")
                                    .font(.system(size:12))
                                    .padding(.leading, 10)
                                    .offset(x:30)
                            }
                            
                            HStack(spacing: 60){
                                VStack(alignment: .leading, spacing:1){
                                    Text("M")
                                        .padding(.bottom, 4)
                                    Text("Tu")
                                        .padding(.bottom, 4)
                                    Text("W")
                                        .padding(.bottom, 4)
                                    Text("T")
                                        .padding(.bottom, 4)
                                    Text("F")
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
                        }
                        Spacer()
                    }
                }
                .ignoresSafeArea(.all, edges: .all)
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
    NavigationStack{
        ProfileView()
    }
}
