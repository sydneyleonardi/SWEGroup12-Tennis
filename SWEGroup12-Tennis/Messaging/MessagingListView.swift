//
//  MessagingListView.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import SwiftUI

//let testData = [Match(name: "kathleen", skilllevel: "0"), Match(name: "sophia", skilllevel: "3"), Match(name: "sydney", skilllevel: "5")]
let messageFilter = Message(name:"", message:"")
struct MessagingListView: View{
    //var matches = testData
    
    let messageFilter: Message
    @ObservedObject private var viewModel = MessagingViewModel()
    
    var body: some View{
        NavigationView{
            List(viewModel.messages){i in
                //if(i.gender == sendFilter.gender || i.type == sendFilter.type){
                    VStack(alignment: .leading){
                            Text(i.name)
                                .font(.headline)
                            Text(i.message)
                                .font(.subheadline)
                            
                        //}
                }
            }
            .navigationBarTitle("Messages")
            .onAppear(){
                self.viewModel.fetchData()
            }
        }
    }
}
#Preview {
    MessagingListView(messageFilter: messageFilter)
}
