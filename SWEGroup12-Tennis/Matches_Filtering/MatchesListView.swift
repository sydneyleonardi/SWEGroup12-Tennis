//
//  MatchesListView.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import SwiftUI

//let testData = [Match(name: "kathleen", skilllevel: "0"), Match(name: "sophia", skilllevel: "3"), Match(name: "sydney", skilllevel: "5")]
let sendFilter = Match(name:"", skillLevel:"", email:"", gender:"", type:"")
struct MatchesListView: View{
    
    //var matches = testData
    
    let sendFilter: Match
    @ObservedObject private var viewModel = MatchesViewModel()
    
    var body: some View{
        NavigationView{
            List(viewModel.matches){i in
                if(i.gender == sendFilter.gender || sendFilter.type == "" || i.type == sendFilter.type || sendFilter.type == ""){
                    HStack(spacing: 10){
                        VStack(alignment: .leading){
                            Text(i.name)
                                .font(.headline)
                            Text(i.gender)
                                .font(.subheadline)
                            Text("Skill Level: "+i.skillLevel)
                                .font(.subheadline)
                            Text("Email: " + i.email)
                                .font(.subheadline)
                            Text("Type: "+i.type)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        VStack(alignment: .leading){
                            NavigationLink("  View Profile",destination: ProfileView())
                                .frame(width:150, height:40)
                                .foregroundColor(.black)
                                .background(CustomColor.myColor)
                                .cornerRadius(15)
                            NavigationLink("  Quick Match",destination: FilterView())
                                .frame(width:150, height:40)
                                .foregroundColor(.black)
                                .background(CustomColor.myColor)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            .navigationBarTitle("Potential Matches")
            .onAppear(){
                self.viewModel.fetchData()
            }
        }
    }
}
#Preview {
    MatchesListView(sendFilter: sendFilter)
}
