//
//  DropdownMenu.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/9/23.
//

import SwiftUI

struct DropdownMenu: View {
    @State private var selectedOption = ""
    let options = ["Male", "Female"]

        var body: some View {
            VStack {
                Picker("Gender", selection: $selectedOption) {
                    ForEach(options, id:\.self) { option in
                        Text(option)
                    }
                }
                .padding()
                .labelsHidden()
                .frame(width:145, height:50)
                .foregroundColor(.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }
        }
    }


#Preview {
    DropdownMenu()
}
