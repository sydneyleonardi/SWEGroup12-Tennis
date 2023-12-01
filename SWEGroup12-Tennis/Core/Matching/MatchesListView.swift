//
//  MatchesListView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/14/23.
//

import SwiftUI
import SDWebImageSwiftUI

let sendFilter = Match(userID: "", name:"", skillLevel:"", gender:"", type:"", time:[])
struct MatchesListView: View{
    
    //var matches = testData
    @State private var sendFilter = Match(userID: "", name:"", skillLevel:"", gender:"", type:"", time:[])
    //let sendFilter: Match
    @ObservedObject private var viewModel = MatchesViewModel()
    @Binding var showSignIn: Bool
    @State private var showFilterOptions = false
    
    @ObservedObject var profileVM = ProfileViewModel()
    
    var curUser: DBUser?
    
    var body: some View{
        let currUser = profileVM.user?.name ?? ""
        
        NavigationView {
            VStack{
                Button("Show Filters") {
                    self.showFilterOptions.toggle()
                }
                if showFilterOptions {
                    FilterOptionsMenuView(showFilterOptions: $showFilterOptions, sendFilter: $sendFilter, applyFilters: {
                        print("Updated sendFilter attributes: \(sendFilter.skillLevel)")
                        print("This is the current user\(currUser)")
                    })
                }
                //model to view all potential partners pulled from DB
                List(viewModel.matches) { i in
                    let currTime = profileVM.user?.datesSelected ?? []
                    if viewModel.filterMatches(match: i, sendFilter: sendFilter, currUser: currUser, currTime: currTime) {
                        NavigationLink(destination: OtherProfileView(curUser: .constant(i.userID) , showSignIn: $showSignIn)) {
                            
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text(i.name)
                                        .font(.headline)
                                    Text(i.gender)
                                        .font(.subheadline)
                                    Text("Skill Level: " + i.skillLevel)
                                        .font(.subheadline)
                                    Text("Type: " + i.type)
                                        .font(.subheadline)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Potential Players")
                .onAppear() {
                    self.viewModel.fetchData()
                    Task{
                        try? await profileVM.loadCurrentUser()
                    }
                }
            }
        }
    }
}

#Preview {
    MatchesListView(showSignIn: .constant(false))
}
