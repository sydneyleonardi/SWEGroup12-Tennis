//
//  ProfileViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/27/23.
//

import Foundation

// Displays a User's Profile Information

@MainActor
final class ProfileViewModel: ObservableObject
{
    @Published private(set) var user: DBUser? = nil
    
    // Selection Variables
    @Published var isSelected = false
    @Published var isSelected2 = false
    @Published var isSelected3 = false
    @Published var isSelected4 = false
    @Published var isSelected5 = false
    
    // Date Availability Variables
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
    
    // Load the Current User from Database
    func loadCurrentUser() async throws {
        let authUser = try AuthManager.shared.fetchUser()
        self.user = try await UserManager.shared.getUser(userId: authUser.uid)
        
        // logic for skill level
        if(user?.skillLevel == "Beginner"){
            isSelected = true
            isSelected2 = false
            isSelected3 = false
            
        }else
        {
            if(user?.skillLevel == "Club")
            {
                isSelected2 = true
                isSelected = false
                isSelected3 = false
                
            }else {
                if(user?.skillLevel == "College")
                {
                    isSelected3 = true
                    isSelected = false
                    isSelected2 = false
                    
                }
            }
        }
        
        // logic for play type buttons
        if(user?.playType == "Singles"){
            isSelected4 = true
            isSelected5 = false
        }else {
            if(user?.playType == "Doubles"){
                isSelected5 = true
                isSelected4 = false
            }
        }
        
        // logic for availability section
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
