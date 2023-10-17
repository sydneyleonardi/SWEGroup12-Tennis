//
//  CreateProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

import SwiftUI

// Fix UI but that's for anotehr day 

@MainActor
final class CreateProfileViewModel: ObservableObject{
    @Published var name = ""
    @Published var gender = ""
    @Published var description = ""
    @Published var age = ""
    @Published var skillLevel = ""
    @Published var playType = ""
    
    func createUserProfile () async throws
    {
        guard !name.isEmpty, !gender.isEmpty else {
            print ("No name or gender")
            return
        }
        
        let authUser = try AuthManager.shared.fetchUser()
        
        let user = DBUser(userId: authUser.uid, name: name, gender: gender, age: age, skillLevel: skillLevel, playType: playType, email: authUser.email, description: description)
        
        try await UserManager.shared.createUserProfile(user: user)
    }
    
}



struct CreateProfileView: View {
    
    // Selection variables
    
    // Skill Level
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var isSelected3 = false

    // Type of Play
    @State private var isSelected4 = false
    @State private var isSelected5 = false
    
    // Availability
    @State private var isSelected6 = false
    @State private var isSelected7 = false
    @State private var isSelected8 = false
    @State private var isSelected9 = false
    @State private var isSelected10 = false
    @State private var isSelected11 = false
    @State private var isSelected12 = false
    @State private var isSelected13 = false
    @State private var isSelected14 = false
    @State private var isSelected15 = false
    @State private var isSelected16 = false
    @State private var isSelected17 = false
    @State private var isSelected18 = false
    @State private var isSelected19 = false
    @State private var isSelected20 = false
    
    
    @State private var showAlert = false
    @State private var alertText = ""
    
    // Screen bindings
    @Binding var showSignIn: Bool
    @Binding var showCreateUser: Bool
    
    // View Model
    @StateObject private var viewModel = CreateProfileViewModel()
    

    var body: some View {
        NavigationView{
            VStack{
                Text("Create Your Profile!")
                    .font(.title)
                    .padding(.top, 20)
              
                TextField("Full Name", text: $viewModel.name)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(20)
                
                TextField("About You", text: $viewModel.description)
                    .autocorrectionDisabled(true)
                    .padding()
                    .frame(width:300, height:75, alignment: .top)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(20)
                
                HStack{
                    TextField("Gender", text: $viewModel.gender)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width:145, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(20)
                    
                    TextField("Age", text: $viewModel.age)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width:145, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(20)
                }
                VStack{
                    Text("Please Rate Your Skill Level")
                    
                    HStack(spacing: 50){
                        SelectButton(isSelected: $isSelected, color:CustomColor.myColor)
                            .onTapGesture{
                                isSelected.toggle()
                                isSelected2 = false
                                isSelected3 = false
                                viewModel.skillLevel = "Beginner"
                            }
                        
                        SelectButton(isSelected: $isSelected2, color:CustomColor.myColor)
                            .onTapGesture{
                                isSelected2.toggle()
                                isSelected = false
                                isSelected3 = false
                                viewModel.skillLevel = "Club"
                            }
                        
                        SelectButton(isSelected: $isSelected3, color:CustomColor.myColor)
                            .onTapGesture{
                                isSelected3.toggle()
                                isSelected2 = false
                                isSelected = false
                                viewModel.skillLevel = "College"
                            }
                    }
                    
                    HStack(spacing: 16){
                        Text("Beginner")
                        Text("Club")
                        Text("College")
                    }
                    
        
                }
                .padding()
                .frame(width:300, height:100)
                .background(Color.black.opacity(0.05))
                .cornerRadius(20)
                
                
                VStack{
                    Text("Are you looking to Play...")
                    HStack(spacing: 50){
                        SelectButton(isSelected: $isSelected4, color:CustomColor.myColor)
                            .onTapGesture{
                                isSelected4.toggle()
                                isSelected5 = false
                                viewModel.playType = "Singles"
                            }
                        SelectButton(isSelected: $isSelected5, color:CustomColor.myColor)
                            .onTapGesture{
                                isSelected5.toggle()
                                isSelected4 = false
                                viewModel.playType = "Doubles"
                            }
                    }
                    
                    HStack(spacing: 15){
                        Text("Singles")
                        Text("Doubles")
                    }
                }
                .padding()
                .frame(width:300, height:100)
                .background(Color.black.opacity(0.05))
                .cornerRadius(20)
                
                VStack{
                    Text("Availability")
                        .padding(.bottom, 3)
                    HStack{
                        ForEach(["", "Morning","Afternoon", "Evening"],id: \.self){
                            Text("\($0)")
                                .frame(width:80)
                                .offset(x:-18)
                                            
                                    }
                                }
                    HStack(spacing: 5){
                        Text("(8am-12pm)")
                            .font(.system(size:12))
                            .padding(.leading, 20)
                            .offset(x: 10)
                        Text("(12pm-4pm)")
                            .font(.system(size:12))
                            .padding(.leading, 10)
                            .offset(x:10)
                        Text("(4pm-8pm)")
                            .font(.system(size:12))
                            .padding(.leading, 10)
                            .offset(x:15)
                    }
                    
                    HStack(spacing: 60){
                        VStack(alignment: .leading, spacing:1){
                            Text("M")
                                .padding(.bottom, 4)
                            Text("Tu")
                                .padding(.bottom, 4)
                            Text("W")
                                .padding(.bottom, 4)
                            Text("Th")
                                .padding(.bottom, 4)
                            Text("F")
                            }
                        VStack{
                            SelectButton(isSelected: $isSelected6 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected7 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected8 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected2.toggle()
                                }
                            
                            SelectButton(isSelected: $isSelected9 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected3.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected10 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected4.toggle()
                                }
                        }
                        .offset(x:-20)
                        
                        VStack{
                            SelectButton(isSelected: $isSelected11 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected12 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected13 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected2.toggle()
                                }
                            
                            SelectButton(isSelected: $isSelected14 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected3.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected15 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected4.toggle()
                                }
                        }
                        .offset(x:-20)
                        
                        VStack{
                            SelectButton(isSelected: $isSelected16 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected17 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected18 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected2.toggle()
                                }
                            
                            SelectButton(isSelected: $isSelected19 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected3.toggle()
                                }
                                           
                            SelectButton(isSelected: $isSelected20 , color: CustomColor.myColor)
                                .onTapGesture{
                                    isSelected4.toggle()
                                }
                        }
                        .offset(x:-20)
                    }
                    
                                   
                }
                .padding()
                .frame(width:300, height:225)
                .background(Color.black.opacity(0.05))
                .cornerRadius(20)
                
                Button{
                    Task{
                        do{
                            try await viewModel.createUserProfile()
                            showSignIn = false
                            showCreateUser = false
                        }catch{
                            print(error)
                        }
                    }
                }label: {
                    Text("Save")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(CustomColor.myColor)
                        .cornerRadius(20)
                        .padding()
                }
                Spacer()
                
            }
        }
    }
}

#Preview {
    NavigationStack{
        CreateProfileView(showSignIn: .constant(false), showCreateUser: .constant(false))
    }
}
