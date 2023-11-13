//
//  CreateProfileView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// Add Error Handling

import SwiftUI

struct CreateProfileView: View {
    
    // Skill Level
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var isSelected3 = false

    // Type of Play
    @State private var isSelected4 = false
    @State private var isSelected5 = false
    
    // Availability
    @State private var isSelected6 = false
    @State private var isSelected7 = false
    @State private var isSelected8 = false
    @State private var isSelected9 = false
    @State private var isSelected10 = false
    @State private var isSelected11 = false
    @State private var isSelected12 = false
    @State private var isSelected13 = false
    @State private var isSelected14 = false
    @State private var isSelected15 = false
    @State private var isSelected16 = false
    @State private var isSelected17 = false
    @State private var isSelected18 = false
    @State private var isSelected19 = false
    @State private var isSelected20 = false
    
    // Navigation Variables
    @State private var showProfile = false
    @State private var shouldShowImagePicker = false
    
    // Dropdown Options
    @State private var selectedOption = ""
    let options = ["Male", "Female"]
    
    // View Model
    @StateObject private var viewModel = CreateProfileViewModel()

    var body: some View {
        NavigationView{
            VStack{
                Text("Create Your Profile!")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                ScrollView{
                    VStack{
                        Button{
                            shouldShowImagePicker.toggle()
                        }label:{
                            VStack{
                                if let image = viewModel.profileImage{
                                    Image(uiImage:viewModel.profileImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                }else {
                                    Image(systemName: "person.circle")
                                        .font(.system(size: 80))
                                        .accentColor(CustomColor.myColor)
                                        .padding(.bottom, 2)
                                }
                                
                                Text("Add Picture")
                                    .font(.subheadline)
                                    .bold()
                                    .padding(.bottom, 5)
                                    .accentColor(.black)
                            }
                            
                        }
                        
                        
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Bio")
                                .font(.subheadline)
                                .bold()
                            TextField("Full Name", text: $viewModel.name)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .padding(.leading, 20)
                                .frame(width:300, height:50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                            
                            HStack{
                                Picker("", selection: $selectedOption) {
                                    ForEach(options, id:\.self) { option in
                                            Text(option).tag(option)
                                    }
                                }
                                .padding()
                                .labelsHidden()
                                .frame(width:145, height:50)
                                .accentColor(.black)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .onChange(of: selectedOption) { newValue in
                                    viewModel.gender = newValue
                                }
                                
                                
                                TextField("Age", text: $viewModel.age)
                                    .autocorrectionDisabled(true)
                                    .autocapitalization(.none)
                                    .padding()
                                    .frame(width:145, height:50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            
                            TextField("About You", text: $viewModel.description)
                                .autocorrectionDisabled(true)
                                .padding()
                                .frame(width:300, height:75, alignment: .top)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .padding(.bottom, 3)
                            
                            Text("Skill Level")
                                .font(.subheadline)
                                .bold()
                            VStack{
                                HStack(spacing: 50){
                                    SelectButton(isSelected: $isSelected, color:CustomColor.myColor)
                                        .onTapGesture{
                                            isSelected.toggle()
                                            isSelected2 = false
                                            isSelected3 = false
                                            viewModel.skillLevel = "Beginner"
                                        }
                                    
                                    SelectButton(isSelected: $isSelected2, color:CustomColor.myColor)
                                        .onTapGesture{
                                            isSelected2.toggle()
                                            isSelected = false
                                            isSelected3 = false
                                            viewModel.skillLevel = "Club"
                                        }
                                    
                                    SelectButton(isSelected: $isSelected3, color:CustomColor.myColor)
                                        .onTapGesture{
                                            isSelected3.toggle()
                                            isSelected2 = false
                                            isSelected = false
                                            viewModel.skillLevel = "College"
                                        }
                                }
                                
                                HStack(spacing: 16){
                                    Text("Beginner")
                                    Text("Club")
                                    Text("College")
                                }
                                
                    
                            }
                            .padding()
                            .frame(width:300, height:75)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .padding(.bottom, 3)
                            
                            Text("Play Type")
                                .font(.subheadline)
                                .bold()
                            VStack{
                                HStack(spacing: 50){
                                    SelectButton(isSelected: $isSelected4, color:CustomColor.myColor)
                                        .onTapGesture{
                                            isSelected4.toggle()
                                            isSelected5 = false
                                            viewModel.playType = "Singles"
                                        }
                                    SelectButton(isSelected: $isSelected5, color:CustomColor.myColor)
                                        .onTapGesture{
                                            isSelected5.toggle()
                                            isSelected4 = false
                                            viewModel.playType = "Doubles"
                                        }
                                }
                                
                                HStack(spacing: 15){
                                    Text("Singles")
                                    Text("Doubles")
                                }
                            }
                            .padding()
                            .frame(width:300, height:75)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .padding(.bottom, 3)
                            
                            Text("Availability")
                                .font(.subheadline)
                                .bold()
                                .padding(.bottom, 3)
                            VStack{
                                HStack{
                                    ForEach(["", "Morning","Afternoon", "Evening"],id: \.self){
                                        Text("\($0)")
                                            .frame(width:80)
                                            .offset(x:-18)
                                                        
                                                }
                                            }
                                HStack(spacing: 5){
                                    Text("(8am-12pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 20)
                                        .offset(x: 10)
                                    Text("(12pm-4pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 10)
                                        .offset(x:10)
                                    Text("(4pm-8pm)")
                                        .font(.system(size:12))
                                        .padding(.leading, 10)
                                        .offset(x:15)
                                }
                                
                                HStack(spacing: 60){
                                    VStack(alignment: .leading, spacing:1){
                                        Text("M")
                                            .padding(.bottom, 4)
                                        Text("Tu")
                                            .padding(.bottom, 4)
                                        Text("W")
                                            .padding(.bottom, 4)
                                        Text("Th")
                                            .padding(.bottom, 4)
                                        Text("F")
                                        }
                                    VStack{
                                        SelectButton(isSelected: $isSelected6 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected6.toggle()
                                                if(viewModel.datesSelected[0] == 0)
                                                {
                                                    viewModel.datesSelected[0] = 1
                                                }else {
                                                    viewModel.datesSelected[0] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected7 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected7.toggle()
                                                if(viewModel.datesSelected[1] == 0)
                                                {
                                                    viewModel.datesSelected[1] = 1
                                                }else {
                                                    viewModel.datesSelected[1] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected8 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected8.toggle()
                                                if(viewModel.datesSelected[2] == 0)
                                                {
                                                    viewModel.datesSelected[2] = 1
                                                }else {
                                                    viewModel.datesSelected[2] = 0
                                                }
                                            }
                                        
                                        SelectButton(isSelected: $isSelected9 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected9.toggle()
                                                if(viewModel.datesSelected[3] == 0)
                                                {
                                                    viewModel.datesSelected[3] = 1
                                                }else {
                                                    viewModel.datesSelected[3] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected10 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected10.toggle()
                                                if(viewModel.datesSelected[4] == 0)
                                                {
                                                    viewModel.datesSelected[4] = 1
                                                }else {
                                                    viewModel.datesSelected[4] = 0
                                                }
                                            }
                                    }
                                    .offset(x:-20)
                                    
                                    VStack{
                                        SelectButton(isSelected: $isSelected11 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected11.toggle()
                                                if(viewModel.datesSelected[5] == 0)
                                                {
                                                    viewModel.datesSelected[5] = 1
                                                }else {
                                                    viewModel.datesSelected[5] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected12 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected12.toggle()
                                                if(viewModel.datesSelected[6] == 0)
                                                {
                                                    viewModel.datesSelected[6] = 1
                                                }else {
                                                    viewModel.datesSelected[6] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected13 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected13.toggle()
                                                if(viewModel.datesSelected[7] == 0)
                                                {
                                                    viewModel.datesSelected[7] = 1
                                                }else {
                                                    viewModel.datesSelected[7] = 0
                                                }
                                            }
                                        
                                        SelectButton(isSelected: $isSelected14 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected14.toggle()
                                                if(viewModel.datesSelected[8] == 0)
                                                {
                                                    viewModel.datesSelected[8] = 1
                                                }else {
                                                    viewModel.datesSelected[8] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected15 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected15.toggle()
                                                if(viewModel.datesSelected[9] == 0)
                                                {
                                                    viewModel.datesSelected[9] = 1
                                                }else {
                                                    viewModel.datesSelected[9] = 0
                                                }
                                            }
                                    }
                                    .offset(x:-20)
                                    
                                    VStack{
                                        SelectButton(isSelected: $isSelected16 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected16.toggle()
                                                if(viewModel.datesSelected[10] == 0)
                                                {
                                                    viewModel.datesSelected[10] = 1
                                                }else {
                                                    viewModel.datesSelected[10] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected17 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected17.toggle()
                                                if(viewModel.datesSelected[11] == 0)
                                                {
                                                    viewModel.datesSelected[11] = 1
                                                }else {
                                                    viewModel.datesSelected[11] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected18 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected18.toggle()
                                                if(viewModel.datesSelected[12] == 0)
                                                {
                                                    viewModel.datesSelected[12] = 1
                                                }else {
                                                    viewModel.datesSelected[12] = 0
                                                }
                                            }
                                        
                                        SelectButton(isSelected: $isSelected19 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected19.toggle()
                                                if(viewModel.datesSelected[13] == 0)
                                                {
                                                    viewModel.datesSelected[13] = 1
                                                }else {
                                                    viewModel.datesSelected[13] = 0
                                                }
                                            }
                                                       
                                        SelectButton(isSelected: $isSelected20 , color: CustomColor.myColor)
                                            .onTapGesture{
                                                isSelected20.toggle()
                                                if(viewModel.datesSelected[14] == 0)
                                                {
                                                    viewModel.datesSelected[14] = 1
                                                }else {
                                                    viewModel.datesSelected[14] = 0
                                                }
                                            }
                                    }
                                    .offset(x:-20)
                                }
                                
                                               
                            }
                            .padding()
                            .frame(width:300, height:225)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            
                            Button{
                                Task{
                                    do{
                                        try await viewModel.createUserProfile()
                                        showProfile  = true
                                    }catch{
                                        print(error)
                                    }
                                }
                            }label: {
                                Text("Save")
                                    .font(.headline)
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(CustomColor.myColor)
                            .cornerRadius(10)
                            .padding(.top, 10)
                            
                            NavigationLink("", destination: HomeView().navigationBarBackButtonHidden(true), isActive: $showProfile)
                        }
                        .padding(.leading, 45)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $viewModel.profileImage)
        }
    }
}

#Preview {
    NavigationStack{
        CreateProfileView()
    }
}
