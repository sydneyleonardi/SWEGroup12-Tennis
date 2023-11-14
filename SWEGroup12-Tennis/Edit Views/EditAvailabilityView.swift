//
//  EditAvailabilityView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/31/23.
//
import SwiftUI

struct EditAvailabilityView: View {

    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
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

    var body: some View {
        VStack{
            Text("Availability")
                .font(.headline)
                .padding(.bottom, 30)

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
                                if(viewModel.changeArray[0] == 0)
                                {
                                    viewModel.changeArray[0] = 1
                                }else {
                                    viewModel.changeArray[0] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected7 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected7.toggle()
                                if(viewModel.changeArray[1] == 0)
                                {
                                    viewModel.changeArray[1] = 1
                                }else {
                                    viewModel.changeArray[1] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected8 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected8.toggle()
                                if(viewModel.changeArray[2] == 0)
                                {
                                    viewModel.changeArray[2] = 1
                                }else {
                                    viewModel.changeArray[2] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected9 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected9.toggle()
                                if(viewModel.changeArray[3] == 0)
                                {
                                    viewModel.changeArray[3] = 1
                                }else {
                                    viewModel.changeArray[3] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected10 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected10.toggle()
                                if(viewModel.changeArray[4] == 0)
                                {
                                    viewModel.changeArray[4] = 1
                                }else {
                                    viewModel.changeArray[4] = 0
                                }
                            }
                    }
                    .offset(x:-20)

                    VStack{
                        SelectButton(isSelected: $isSelected11 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected11.toggle()
                                if(viewModel.changeArray[5] == 0)
                                {
                                    viewModel.changeArray[5] = 1
                                }else {
                                    viewModel.changeArray[5] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected12 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected12.toggle()
                                if(viewModel.changeArray[6] == 0)
                                {
                                    viewModel.changeArray[6] = 1
                                }else {
                                    viewModel.changeArray[6] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected13 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected13.toggle()
                                if(viewModel.changeArray[7] == 0)
                                {
                                    viewModel.changeArray[7] = 1
                                }else {
                                    viewModel.changeArray[7] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected14 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected14.toggle()
                                if(viewModel.changeArray[8] == 0)
                                {
                                    viewModel.changeArray[8] = 1
                                }else {
                                    viewModel.changeArray[8] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected15 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected15.toggle()
                                if(viewModel.changeArray[9] == 0)
                                {
                                    viewModel.changeArray[9] = 1
                                }else {
                                    viewModel.changeArray[9] = 0
                                }
                            }
                    }
                    .offset(x:-20)

                    VStack{
                        SelectButton(isSelected: $isSelected16 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected16.toggle()
                                if(viewModel.changeArray[10] == 0)
                                {
                                    viewModel.changeArray[10] = 1
                                }else {
                                    viewModel.changeArray[10] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected17 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected17.toggle()
                                if(viewModel.changeArray[11] == 0)
                                {
                                    viewModel.changeArray[11] = 1
                                }else {
                                    viewModel.changeArray[11] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected18 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected18.toggle()
                                if(viewModel.changeArray[12] == 0)
                                {
                                    viewModel.changeArray[12] = 1
                                }else {
                                    viewModel.changeArray[12] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected19 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected19.toggle()
                                if(viewModel.changeArray[13] == 0)
                                {
                                    viewModel.changeArray[13] = 1
                                }else {
                                    viewModel.changeArray[13] = 0
                                }
                            }

                        SelectButton(isSelected: $isSelected20 , color: CustomColor.myColor)
                            .onTapGesture{
                                isSelected20.toggle()
                                if(viewModel.changeArray[14] == 0)
                                {
                                    viewModel.changeArray[14] = 1
                                }else {
                                    viewModel.changeArray[14] = 0
                                }
                            }
                    }
                    .offset(x:-20)
                }


            }
            .padding()
            .frame(width:315, height:225)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .padding(.bottom, 20)

            Button{
                Task{
                    viewModel.changeCategory = "datesSelected"
                    viewModel.dates = true
                    try await viewModel.editUserProfile()
                    dismiss()
                }
            }label: {
                Text("Save")
            }
            .padding(30)
            .frame(width:300, height:50)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .foregroundColor(.black)
        }

        Spacer()
    }
}

#Preview {
    EditAvailabilityView()
}
