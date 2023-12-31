//
//  HomeView.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/22/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            
            //replace with Kathleen's Matching View
            // edit showSignInView 
            MatchesListView(showSignIn: .constant(false))
                .tabItem { Label("Matches", systemImage: "person.3") }
            
            //replace with CalendarView
            //CalendarView()
            CalendarResView()
                .tabItem { Label("Calendar", systemImage: "calendar") }
            
            //replace with Jhanavi's Messaging View
            MainMessagesView()
                .tabItem { Label("Chat", systemImage: "message.fill") }
            
            // potentially missing settings
            // fix scroll, why is it in the middle of the screen 
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle")}
        }
        .accentColor(CustomColor.myColor)
    }
}




#Preview {
    HomeView()
}


