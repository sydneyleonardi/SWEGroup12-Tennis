//
//  SelectButton.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/28/23.
//

import SwiftUI

// Creates a customizable select button in the app 
struct SelectButton: View {
    @Binding var isSelected:Bool
    @State var color: Color
    
    var body: some View {
        VStack{
                Capsule()
                    .frame(width:17, height:17)
                    .foregroundColor(isSelected ? color: .gray)
        }
    }
}

#Preview {
    NavigationStack{
        SelectButton(isSelected:.constant(false) ,color: CustomColor.myColor)
    }
}
