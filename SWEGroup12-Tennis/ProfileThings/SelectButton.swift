//
//  SelectButton.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/28/23.
//

import SwiftUI

struct SelectButton: View {
    @Binding var isSelected:Bool
    @State var color: Color
    
    var body: some View {
        //ZStack{
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
