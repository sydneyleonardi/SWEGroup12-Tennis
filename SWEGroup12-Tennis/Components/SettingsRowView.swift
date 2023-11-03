//
//  SettingsRowView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/10/23.
//

import SwiftUI

// Creates a customizable row in settings
struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
