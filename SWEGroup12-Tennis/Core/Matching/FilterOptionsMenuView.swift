//
//  FilterOptionsMenuView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/14/23.
//

import SwiftUI

struct FilterOptionsMenuView: View {
    @Binding var showFilterOptions: Bool
    @Binding var sendFilter: Match
    //(userID: "", name:"", skillLevel:"", email:"", gender:"", type:"")
    var applyFilters: () -> Void
    //@Binding var filtersApplied: Bool
    //@Binding var sendFilter: Match
    @State private var isSelectedBeg = false
    @State private var isSelectedClu = false
    @State private var isSelectedColl = false
    @State private var isSelectedMal = false
    @State private var isSelectedFem = false
    @State private var isSelectedSing = false
    @State private var isSelectedDoub = false
    var body: some View {
        //@State var isSelected200: Bool = false
        //@State var sendFilter = Match(userID: "", name:"", skillLevel:"", email:"", gender:"", type:"")
        // Your code for filter options
        // Apply Filters button or logic
        //var isSelectedBeg = false
        VStack {
            //Text("Filter For Match")
                //.font(.system(size: 15))

            //var isSelected300 = false
            //.offset(y: -150) // Adjust this offset as necessary
            HStack(spacing: 30){
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedBeg.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedBeg)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedBeg)")
                    
                    if isSelectedBeg {
                        $sendFilter.wrappedValue.skillLevel = "Beginner"
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.skillLevel = ""
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedBeg ? Color.accentColor : Color(UIColor.lightGray))
                        //.foregroundColor(!isSelectedBeg ? Color.gray : Color.gray)
                        //.foregroundColor(isSelectedBeg ? Color.accentColor : Color.accentColor)
                        .overlay(
                            Text("Beginner")
                                .foregroundColor(.white)
                        )
                }
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedClu.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedClu)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedClu)")
                    
                    if isSelectedClu {
                        $sendFilter.wrappedValue.skillLevel = "Club"
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.skillLevel = ""
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedClu ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("Club")
                                .foregroundColor(.white)
                        )
                }
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedColl.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedColl)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedColl)")
                    
                    if isSelectedColl {
                        $sendFilter.wrappedValue.skillLevel = "College"
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.skillLevel = ""
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedColl ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("College")
                                .foregroundColor(.white)
                        )
                }
                /*Button(action: {
                 isSelected53.toggle()
                 if isSelected53 {
                 $sendFilter.wrappedValue.skillLevel = "College"
                 print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                 applyFilters()
                 }
                 }) {
                 SelectButtonFilter(isSelected: $isSelected53, color: Color.accentColor)
                 }*/
            }
            HStack(spacing: 50){
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedMal.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedMal)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedMal)")
                    
                    if isSelectedMal {
                        $sendFilter.wrappedValue.gender = "Male"
                        print("Updated sendFilter attributes: \(sendFilter.gender)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.gender = ""
                        print("Updated sendFilter attributes: \(sendFilter.gender)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedMal ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("Male")
                                .foregroundColor(.white)
                        )
                }
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedFem.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedFem)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedFem)")
                    
                    if isSelectedFem {
                        $sendFilter.wrappedValue.gender = "Female"
                        print("Updated sendFilter attributes: \(sendFilter.gender)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.gender = ""
                        print("Updated sendFilter attributes: \(sendFilter.gender)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedFem ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("Female")
                                .foregroundColor(.white)
                        )
                }
            }
            HStack(spacing: 50){
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedSing.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedSing)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedSing)")
                    
                    if isSelectedSing {
                        $sendFilter.wrappedValue.type = "Singles"
                        print("Updated sendFilter attributes: \(sendFilter.type)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.type = ""
                        print("Updated sendFilter attributes: \(sendFilter.type)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedSing ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("Singles")
                                .foregroundColor(.white)
                        )
                }
                Button(action: {
                    // Comment out or remove the following line
                    //var isSelected300 = false
                    isSelectedDoub.toggle()
                    
                    print("Before setting isSelected200 to true: \(isSelectedDoub)")
                    //isSelected300 = true
                    print("After setting isSelected200 to true: \(isSelectedDoub)")
                    
                    if isSelectedDoub {
                        $sendFilter.wrappedValue.type = "Doubles"
                        print("Updated sendFilter attributes: \(sendFilter.type)")
                        applyFilters()
                    }
                    else{
                        $sendFilter.wrappedValue.type = ""
                        print("Updated sendFilter attributes: \(sendFilter.type)")
                        applyFilters()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(isSelectedDoub ? Color.accentColor : Color(UIColor.lightGray))
                        .overlay(
                            Text("Doubles")
                                .foregroundColor(.white)
                        )
                }
            }
            
        }
        .offset()
        
        
        /* Button("Apply Filters") {
         applyFilters() // This will refresh MatchesListView
         showFilterOptions.toggle() // Minimize the menu
         // Apply the filters
         // ...
         
         // After applying filters, set filtersApplied state to true
         //self.filtersApplied = true
         }
         .offset(y: -20) // Adjust this offset as necessary
         }*/
    }
}
