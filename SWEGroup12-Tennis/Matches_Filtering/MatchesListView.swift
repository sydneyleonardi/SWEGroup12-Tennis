//
//  MatchesListView.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

//current goals
//filter for current user (done)
//filter for current user availibility - automatic -- ?
//bug with voeralpping nav bar when viewing a users profile


//current goals
//reset filtering button
//uploading data for time and dates
//filtering on time and date
//better filtering logic
//error handling for invalid profiles
//make advanced filter button more visible (darker color)

import SwiftUI

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
    //check two time availibilty arrays for any available overlap
    /*func arraysHaveCommonTime(currTime: [Int], matchTime: [Int]) -> Bool {
        for (curr, match) in zip(currTime, matchTime) {
            if curr == 1 && match == 1 {
                return true
            }
        }
        return false
    }
    //automatically filter matches according to shared time availability
    //automatically remove the current user from potential matches
    //manually apply filter preferences from top bar
    func filterMatches(match: Match, sendFilter: Match, currUser: String, currTime: [Int]) -> Bool {
        return (sendFilter.gender.isEmpty || match.gender == sendFilter.gender) &&
               (sendFilter.skillLevel.isEmpty || match.skillLevel == sendFilter.skillLevel) &&
               (sendFilter.type.isEmpty || match.type == sendFilter.type) &&
               (currUser != match.name) &&
               arraysHaveCommonTime(currTime: currTime, matchTime: match.time)
    }*/
    
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
                                VStack(alignment: .center) {
                                    Text("Quick Match")
                                        .frame(width: 150, height: 40)
                                        .background(Color.accentColor)
                                        .cornerRadius(20)
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            viewModel.alert = true
                                        }
                                        .alert(isPresented: $viewModel.alert) {
                                            Alert(title: Text("Match Request Sent!"),
                                                  message: Text("Pending Approval"),
                                                  dismissButton: .default(Text("OK")) {
                                                viewModel.alert = false
                                            })
                                        }
                                }
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
