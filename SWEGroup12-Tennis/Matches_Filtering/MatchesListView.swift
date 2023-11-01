//
//  MatchesListView.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import SwiftUI

let sendFilter = Match(name:"", skillLevel:"", email:"", gender:"", type:"")
struct MatchesListView: View{
    
    //var matches = testData
    
    let sendFilter: Match
    @ObservedObject private var viewModel = MatchesViewModel()
    @Binding var showSignIn: Bool
    var body: some View {
        NavigationView {
            //model to view all matched pulled from DB
            //filter logic -- needs ot be further fleshed out
            List(viewModel.matches) { i in
                if ((sendFilter.gender == "") || (i.gender == sendFilter.gender || i.type == sendFilter.type || i.skillLevel == sendFilter.skillLevel)) {
                    //navigate to profile view
                    //updates still need to be made to view specific profile selected
                    NavigationLink(destination: ProfileView(showSignIn: $showSignIn)) {
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
            //navigate to advanced filter screen
            .navigationBarItems(leading:
                                    NavigationLink(destination: FilterView(showSignIn: $showSignIn)) {
                    Text("Advanced Filter")
                    .foregroundColor(Color.accentColor)
                        .frame(width: 175, height: 20)
                        .background()
                        .cornerRadius(15)
                }
                                )
            .navigationBarTitle("Potential Matches")
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}

#Preview {
    MatchesListView(sendFilter: sendFilter, showSignIn: .constant(false))
}

