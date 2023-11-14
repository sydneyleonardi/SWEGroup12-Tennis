//
//  ProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO
// Figure out how to showcase the availability but for another day

import SwiftUI

@MainActor
final class OtherProfileViewModel: ObservableObject
{
    enum UserError: Error {
        case nilUserID
    }
    @Published private(set) var user: DBUser? = nil
    init(userID: String) {
        self.userID = userID
    }
    private var userID: String
    @Published var isSelected = false
    @Published var isSelected2 = false
    @Published var isSelected3 = false
    @Published var isSelected4 = false
    @Published var isSelected5 = false
    @Published var isSelected6 = false
    @Published var isSelected7 = false
    @Published var isSelected8 = false
    @Published var isSelected9 = false
    @Published var isSelected10 = false
    @Published var isSelected11 = false
    @Published var isSelected12 = false
    @Published var isSelected13 = false
    @Published var isSelected14 = false
    @Published var isSelected15 = false
    @Published var isSelected16 = false
    @Published var isSelected17 = false
    @Published var isSelected18 = false
    @Published var isSelected19 = false
    @Published var isSelected20 = false
    
    func loadCurrentUser() async throws {
        if self.userID.isEmpty {
               throw UserError.nilUserID // Assuming UserError is your custom error type
           }
           
           print("User ID:", self.userID)
           self.user = try await UserManager.shared.getUser(userId: self.userID)
        //let authDataResult = try
        //AuthManager.shared.fetchUser()
        //UserManager.shared.getUser(userId: userID)
        //self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        /*guard let userID = self.userID else {
            throw UserError.nilUserID // Assuming UserError is your custom error type
        }
        
        print("User ID:", userID)
        self.user = try await UserManager.shared.getUser(userId: userID)
        //print("User ID:", userID)
        //self.user = try await UserManager.shared.getUser(userId: self.userID)
        */
        // logic for skill level
        if(user?.skillLevel == "Beginner"){
            isSelected = true
            
        }else
        {
            if(user?.skillLevel == "Club")
            {
                isSelected2 = true
                
            }else {
                if(user?.skillLevel == "College")
                {
                    isSelected3 = true
                    
                }
            }
        }
        
        // logic for play type buttons
        if(user?.playType == "Singles"){
            isSelected4 = true
        }else {
            if(user?.playType == "Doubles"){
                isSelected5 = true
            }
        }
    }
    

    
}
struct Profile {
    var userId: String // Unique identifier for each profile
    var name: String
    var bio: String
    // Other profile-related properties
}

struct OtherProfileView: View {
    @Binding var curUser: String
    @Binding var showSignIn: Bool
    @ObservedObject private var viewModel: OtherProfileViewModel

    init(curUser: Binding<String>, showSignIn: Binding<Bool>) {
        _curUser = curUser
        _showSignIn = showSignIn
        _viewModel = ObservedObject(wrappedValue: OtherProfileViewModel(userID: curUser.wrappedValue))
    }
    //create as an environment object not a state object
    //@Binding var curUser: String
    //@ObservedObject private var viewModel = OtherProfileViewModel(userID: curUser)
    //@Binding var curUser: String
    //@Binding var showSignIn: Bool
    
    var body: some View {
        let user = viewModel.user
        //getUser(userId: curUser)
        //self.user = try await UserManager.shared.getUser(userId: curUser)
        
        Image("Logo")
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .padding(.vertical, 10)
        
        VStack(alignment: .leading){
            
            // User name
            Text(user?.name ?? "")
                .font(.title)
            
            // User gender
            Text(user?.gender ?? "")
                .font(.subheadline)
            
            // User age
            Text(user?.age ?? "")
                .font(.subheadline)
                .padding(.bottom, 10)
            
            NavigationLink{/*ChatLogView(chatUser: curUser)*/
                
            }label:
            {
                Text("Match")
                    .foregroundColor(.black)
            }
            .frame(width: 300, height: 25)
            .background(Color.accentColor)
            .cornerRadius(20)
            .padding(.bottom, 30)
            
            // User description
            Text("About")
                .bold()
                .font(.headline)
            
            Text(user?.description ?? "")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            
            // User Skill Level
            Text("Skill Level")
                .bold()
                .font(.headline)
                .padding(.bottom, 5)
            
            VStack{
                HStack(spacing: 50){
                    SelectButton(isSelected: $viewModel.isSelected, color:Color.accentColor)
                    
                    SelectButton(isSelected: $viewModel.isSelected2, color:Color.accentColor)
                    
                    SelectButton(isSelected: $viewModel.isSelected3, color:Color.accentColor)
                }
                
                HStack(spacing: 18){
                    Text("Beginner")
                        .font(.subheadline)
                    Text("Club")
                        .font(.subheadline)
                    Text("College")
                        .font(.subheadline)
                }
                .padding(.bottom, 20)
            }
            
            // User Play Type
            Text("Looking to Play")
                .bold()
                .font(.headline)
                .padding(.bottom, 5)
            
            VStack{
                HStack(spacing: 50){
                    SelectButton(isSelected: $viewModel.isSelected4, color:Color.accentColor)
                    
                    SelectButton(isSelected: $viewModel.isSelected5, color:Color.accentColor)
                    
                }
                
                HStack(spacing: 18){
                    Text("Singles")
                        .font(.subheadline)
                    Text("Doubles")
                        .font(.subheadline)
                }
                .padding(.bottom, 20)
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
                        SelectButton(isSelected: $viewModel.isSelected6 , color: Color.accentColor)
                                       
                        SelectButton(isSelected: $viewModel.isSelected7 , color: Color.accentColor)
                                     
                        SelectButton(isSelected: $viewModel.isSelected8 , color: Color.accentColor)
                        
                        SelectButton(isSelected: $viewModel.isSelected9 , color: Color.accentColor)
                                       
                        SelectButton(isSelected: $viewModel.isSelected10 , color: Color.accentColor)
                            
                    }
                    .offset(x:-20)
                    
                    VStack{
                        SelectButton(isSelected: $viewModel.isSelected11 , color: Color.accentColor)
                                      
                        SelectButton(isSelected: $viewModel.isSelected12 , color: Color.accentColor)
                                      
                        SelectButton(isSelected: $viewModel.isSelected13 , color: Color.accentColor)
                            
                        SelectButton(isSelected: $viewModel.isSelected14 , color: Color.accentColor)
                                     
                        SelectButton(isSelected: $viewModel.isSelected15 , color: Color.accentColor)
                    }
                    .offset(x:-10)
                    
                    VStack{
                        SelectButton(isSelected: $viewModel.isSelected16 , color: Color.accentColor)
                                       
                        SelectButton(isSelected: $viewModel.isSelected17 , color: Color.accentColor)
                                       
                        SelectButton(isSelected: $viewModel.isSelected18 , color: Color.accentColor)
                        
                        SelectButton(isSelected: $viewModel.isSelected19 , color: Color.accentColor)
                                       
                        SelectButton(isSelected: $viewModel.isSelected20 , color: Color.accentColor)
                    }
                    .offset(x:10)
                }
                
                               
            }
               
            Spacer()
            
        }
        .onAppear{
            Task{
                //add param for current user
                try? await viewModel.loadCurrentUser()
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink {
                    SettingsView()
                    //SettingsView(showSignIn: $showSignIn)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                
            }
            
        }
    }
}


#Preview {
    NavigationStack{
        OtherProfileView(curUser: .constant(""),showSignIn: .constant(false))
    }
}
