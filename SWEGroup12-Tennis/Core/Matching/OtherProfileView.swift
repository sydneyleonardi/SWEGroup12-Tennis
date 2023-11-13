//
//  ProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO
// Figure out how to showcase the availability but for another day

import SwiftUI
import SDWebImageSwiftUI

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
        
        if(user?.datesSelected?[0] == 0){
            isSelected6 = false
        }else {
            isSelected6 = true
        }
        
        if(user?.datesSelected?[1] == 0){
            isSelected7 = false
        }else {
            isSelected7 = true
        }
        
        if(user?.datesSelected?[2] == 0){
            isSelected8 = false
        }else {
            isSelected8 = true
        }
        
        if(user?.datesSelected?[3] == 0){
            isSelected9 = false
        }else {
            isSelected9 = true
        }
        
        if(user?.datesSelected?[4] == 0){
            isSelected10 = false
        }else {
            isSelected10 = true
        }
        
        if(user?.datesSelected?[5] == 0){
            isSelected11 = false
        }else {
            isSelected11 = true
        }
        
        if(user?.datesSelected?[6] == 0){
            isSelected12 = false
        }else {
            isSelected12 = true
        }
        
        if(user?.datesSelected?[7] == 0){
            isSelected13 = false
        }else {
            isSelected13 = true
        }
        
        if(user?.datesSelected?[8] == 0){
            isSelected14 = false
        }else {
            isSelected14 = true
        }
        
        if(user?.datesSelected?[9] == 0){
            isSelected15 = false
        }else {
            isSelected15 = true
        }
        
        if(user?.datesSelected?[10] == 0){
            isSelected16 = false
        }else {
            isSelected16 = true
        }
        
        if(user?.datesSelected?[11] == 0){
            isSelected17 = false
        }else {
            isSelected17 = true
        }
        
        if(user?.datesSelected?[12] == 0){
            isSelected18 = false
        }else {
            isSelected18 = true
        }
        
        if(user?.datesSelected?[13] == 0){
            isSelected19 = false
        }else {
            isSelected19 = true
        }
        
        if(user?.datesSelected?[14] == 0){
            isSelected20 = false
        }else {
            isSelected20 = true
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
    var body: some View {
        let user = viewModel.user
        
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        if let profileImageURL = user?.profileImageURL, !profileImageURL.isEmpty {
                                WebImage(url: URL(string: profileImageURL))
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
                                    .transition(.opacity)
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFill()
                                    .scaleEffect(0.5)
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
                        
                    }label:
                    {
                        Text("Match")
                            .foregroundColor(.black)
                    }
                    .frame(width: 300, height: 25)
                    .background(CustomColor.myColor)
                    .cornerRadius(20)
                    .padding(.bottom, 30)
                    
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
                }
            }
            .ignoresSafeArea(.all, edges:.horizontal)
            Spacer()
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
        OtherProfileView(curUser: .constant(""),showSignIn: .constant(false))
    }
}
