//
//  Filters.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/11/23.
//

// import Foundation
// import Foundation
import SwiftUI

struct FilterView: View{
    @State var isSelected: Bool = false
    @State var isSelected1: Bool = false
    @State var isSelected2: Bool = false
    @State var isSelected3: Bool = false
    @State var isSelected4: Bool = false
    @State var isSelected20: Bool = false
    @State var isSelected21: Bool = false
    @State var isSelected22: Bool = false
    @State var isSelected23: Bool = false
    @State var isSelected24: Bool = false
    @State var isSelected30: Bool = false
    @State var isSelected31: Bool = false
    @State var isSelected32: Bool = false
    @State var isSelected33: Bool = false
    @State var isSelected34: Bool = false
    @State var isSelectedMale: Bool = false
    @State var isSelectedFemale: Bool = false
    @State var isSelectedSingles: Bool = false
    @State var isSelectedDoubles: Bool = false
    @State var isSelected51: Bool = false
    @State var isSelected52: Bool = false
    @State var isSelected53: Bool = false
    
    var numberArray = [5, 10, 15, 20, 25]
    //var gender: String = "female"
    @State var sendFilter = Match(name:"", skillLevel:"", email:"", gender:"", type:"")
    //@State var color: Color
    //@State var text: String
    var body: some View{
        //var gender: String = "Female"
        // Image("Logo")
        NavigationView{
            
            ZStack {
                /*var sendFilter = Match(name:"", skillLevel:"", email:"", gender:gender, type:"")*/
                NavigationLink("Apply Filter",destination: MatchesListView(sendFilter:sendFilter))
                    .frame(width:150, height:40)
                    .foregroundColor(.black)
                    .background(CustomColor.myColor)
                    .cornerRadius(15)
                    .offset(y:220)
                VStack(spacing:18){
                    SelectButtonFilter(isSelected: $isSelected , color: CustomColor.myColor)
                        .offset(x:-50, y:-190)
                        .onTapGesture{
                            isSelected.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected1 , color: CustomColor.myColor)
                        .offset(x:-50, y:-190)
                        .onTapGesture{
                            isSelected1.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected2 , color: CustomColor.myColor)
                        .offset(x:-50, y:-190)
                        .onTapGesture{
                            isSelected2.toggle()
                        }
                    SelectButtonFilter(isSelected: $isSelected3 , color: CustomColor.myColor)
                        .offset(x:-50, y:-190)
                        .onTapGesture{
                            isSelected3.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected4 , color: CustomColor.myColor)
                        .offset(x:-50, y:-190)
                        .onTapGesture{
                            isSelected4.toggle()
                        }
                    
                }
                VStack(spacing:18){
                    SelectButtonFilter(isSelected: $isSelected20 , color: CustomColor.myColor)
                        .offset(x:37, y:-190)
                        .onTapGesture{
                            isSelected20.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected21 , color: CustomColor.myColor)
                        .offset(x:37, y:-190)
                        .onTapGesture{
                            isSelected21.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected22 , color: CustomColor.myColor)
                        .offset(x:37, y:-190)
                        .onTapGesture{
                            isSelected22.toggle()
                        }
                    SelectButtonFilter(isSelected: $isSelected23 , color: CustomColor.myColor)
                        .offset(x:37, y:-190)
                        .onTapGesture{
                            isSelected23.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected24 , color: CustomColor.myColor)
                        .offset(x:37, y:-190)
                        .onTapGesture{
                            isSelected24.toggle()
                        }
                    
                }
                VStack(spacing:18){
                    SelectButtonFilter(isSelected: $isSelected30 , color: CustomColor.myColor)
                        .offset(x:128, y:-190)
                        .onTapGesture{
                            isSelected30.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected31 , color: CustomColor.myColor)
                        .offset(x:128, y:-190)
                        .onTapGesture{
                            isSelected31.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected32 , color: CustomColor.myColor)
                        .offset(x:128, y:-190)
                        .onTapGesture{
                            isSelected32.toggle()
                        }
                    SelectButtonFilter(isSelected: $isSelected33 , color: CustomColor.myColor)
                        .offset(x:128, y:-190)
                        .onTapGesture{
                            isSelected33.toggle()
                        }
                    
                    SelectButtonFilter(isSelected: $isSelected34 , color: CustomColor.myColor)
                        .offset(x:128, y:-190)
                        .onTapGesture{
                            isSelected34.toggle()
                        }
                    
                }
                Text("**Filter For Match**")
                    .offset(y:-360)
                    .font(.system(size:27))
                Text("**Time**")
                    .offset(y:-320)
                    .font(.system(size:20))
                
                HStack{
                    ForEach(["Morning",
                             "Afternoon", "Evening"],id: \.self){
                        Text("\($0)")
                            .frame(width:80)
                            .offset(x:40, y:-295)
                    }
                }
                HStack{
                    ForEach(["(8am-12pm)",
                             "(12pm-4pm)", "(4pm-8pm)"],id: \.self){
                        Text("\($0)")
                            .frame(width:80)
                            .offset(x:40, y:-279)
                            .font(.system(size:10))
                    }
                }
                
                VStack(alignment: .leading ){
                    ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"], id: \.self){
                        Text("\($0)")
                            .offset(x:-120, y:-191)
                            .frame(height:27)
                    }
                }
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 350, height: 240)
                    .opacity(0.1)
                    .offset(y:-217)
                
                VStack(){
                    Text("**Gender**")
                        .offset(y:12)
                        .font(.system(size:20))
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 350, height: 70)
                        .opacity(0.1)
                        .offset(y:-32)
                    HStack(spacing:120){
                        ForEach(["Male", "Female"], id: \.self){
                            Text("\($0)")
                                .offset(x:-30, y:-75)
                                .frame(height:27)
                        }
                    }
                    HStack(spacing: 150){
                        SelectButtonFilter(isSelected: $isSelectedMale , color: CustomColor.myColor)
                            .offset(x:20, y:-105)
                            .onTapGesture{
                                isSelectedMale.toggle()
                                sendFilter.gender = "Male"
                                isSelectedFemale = false
                            }
                        SelectButtonFilter(isSelected: $isSelectedFemale , color: CustomColor.myColor)
                            .offset(x:20, y:-105)
                            .onTapGesture{
                                isSelectedFemale.toggle()
                                sendFilter.gender = "Female"
                                isSelectedMale = false
                            }
                    }
                    
                    
                }
                VStack(){
                    Text("**Type**")
                        .offset(y:105)
                        .font(.system(size:20))
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 350, height: 70)
                        .opacity(0.1)
                        .offset(y:60)
                    HStack(spacing:110){
                        ForEach(["Singles", "Doubles"], id: \.self){
                            Text("\($0)")
                                .offset(x:-30, y:17)
                                .frame(height:27)
                        }
                    }
                    HStack(spacing: 150){
                        SelectButtonFilter(isSelected: $isSelectedSingles , color: CustomColor.myColor)
                            .offset(x:20, y:-13)
                            .onTapGesture{
                                isSelectedSingles.toggle()
                                sendFilter.type = "Singles"
                                isSelectedDoubles = false
                            }
                        SelectButtonFilter(isSelected: $isSelectedDoubles , color: CustomColor.myColor)
                            .offset(x:20, y:-13)
                            .onTapGesture{
                                isSelectedDoubles.toggle()
                                sendFilter.type = "Doubles"
                                isSelectedSingles = false
                            }
                    }
                    
                    
                }
                VStack(){
                    Text("**Skill Level**")
                        .offset(y:195)
                        .font(.system(size:20))
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 350, height: 70)
                        .opacity(0.1)
                        .offset(y:153)
                    HStack(spacing:55){
                        ForEach(["Beginner", "Club", "College"], id: \.self){
                            Text("\($0)")
                                .offset(x:-8, y:110)
                                .frame(height:27)
                        }
                    }
                    HStack(spacing: 100){
                        SelectButtonFilter(isSelected: $isSelected51 , color: CustomColor.myColor)
                            .offset(x:60, y:80)
                            .onTapGesture{
                                isSelected51.toggle()
                            }
                        SelectButtonFilter(isSelected: $isSelected52 , color: CustomColor.myColor)
                            .offset(x:33, y:80)
                            .onTapGesture{
                                isSelected52.toggle()
                            }
                        SelectButtonFilter(isSelected: $isSelected53 , color: CustomColor.myColor)
                            .offset(x:30, y:80)
                            .onTapGesture{
                                isSelected53.toggle()
                            }
                    }
                    /*NavigationLink("Apply Filter",destination: MatchesListView())
                     .offset(y:200)*/
                    
                }
                /*Capsule()
                 .foregroundColor(CustomColor.myColor)
                 .offset(y:230)
                 .frame(width:140, height:50)
                 NavigationLink(destination: MatchesListView())
                 Text("Apply Filter")
                 .offset(y:230)
                 .font(.system(size:20))*/
                
            }
        }
        
    }
}
    
    
#Preview {
    FilterView()
}
  /*  struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FilterView(isSelected2: .constant(false), color: CustomColor.myColor
                       , text:"Option")
        }
    }*/

