//
//  CalendarResView.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/31/23.
//

import SwiftUI
import UIKit
//import FSCalendar
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore


//Displays the root calendar view used to display reservations
struct CalendarResView: View {
    
    //tracks date selected on calendar
    @State var selectedDate: Date = Date()

    //VM Object
    @ObservedObject var resVM = ResViewModel()
    
    //@State private var currentRes = false
    @State var availableRes : Bool = true
    
    @State var availableResExist : Bool = false
    @State var yourResExist : Bool = false
    
    //Note: default display is court 1
    @State var courtNum: String = "1"
    
    //call view model to get current user
    @ObservedObject var profileVM = ProfileViewModel()
   
    
    var body: some View {
        
        
        let currUser = profileVM.user?.name ?? ""

        
        NavigationStack {
            ZStack {
                    Color.white
                        .ignoresSafeArea()
                VStack(alignment: .center, spacing: 0){

                    Text("Calendar")
                    .font(.system(size:27))
                    .bold()
                    .animation(.spring(), value: selectedDate)
                    .frame(alignment: .top)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    HStack{
                        //display Available Reservations
                        Button(action: {
                            self.availableRes = true
                            self.yourResExist = false
                        }){
                            Text("Available Reservations")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(.gray)
                        .cornerRadius(20)

                        
                        //display current reservations that have already been made
                        Button(action: {
                            self.availableRes = false
                            self.yourResExist = false
                        }){
                            Text("Current Reservations")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(.gray)
                        .cornerRadius(20)

                        
                        //display current reservations that have already been made
                        Button(action: {
                            self.availableRes = false
                            self.yourResExist = true
                        }){
                            Text("Your Reservations")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(.gray)
                        .cornerRadius(20)
                        //.padding(.bottom, 10)
                    }
                    HStack{
                        //display court1 info
                        Button(action: {
                            courtNum = "1"
                            self.resVM.fetchRes(courtNum: courtNum)
                        }){
                            Text("Court 1")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 85, height: 40)
                        .background(CustomColor.myColor)
                        .cornerRadius(20)
                        
                        //display court 2 info
                        Button(action: {
                            courtNum = "2"
                            self.resVM.fetchRes(courtNum: courtNum)
                        }){
                            Text("Court 2")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 85, height: 40)
                        .background(CustomColor.myColor)
                        .cornerRadius(20)

                        //display court 3 info
                        Button(action: {
                            courtNum = "3"
                            self.resVM.fetchRes(courtNum: courtNum)
                        }){
                            Text("Court 3")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 85, height: 40)
                        .background(CustomColor.myColor)
                        .cornerRadius(20)
                        
                        //display court 4 info
                        Button(action: {
                            courtNum = "4"
                            self.resVM.fetchRes(courtNum: courtNum)
                        }){
                            Text("Court 4")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 85, height: 40)
                        .background(CustomColor.myColor)
                        .cornerRadius(20)
                    }
                    .onAppear(){
                        availableRes = true
        
                    }
                    .padding(.vertical)

                    
                    ScrollView{
                    //Displays calendar
                    DatePicker("Select Date", selection: $selectedDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .tint(CustomColor.myColor)
                        .padding(.horizontal)


                    

                    if (availableRes && !yourResExist){
                        Text("Available Reservations")
                            .font(.headline)
                            .padding()
                    }
                    if (!availableRes && !yourResExist){
                        Text("Current Reservations")
                            .font(.headline)
                            .padding()
                    }
                    if (!availableRes && yourResExist){
                        Text("Your Reservations")
                            .font(.headline)
                            .padding()
                    }
                    
                    Spacer()

                    
                    //diplays and filters reservations previously fetched
                        ForEach(//sort arrays by start time
                            resVM.reservations.sorted(by: {
                            res1, res2 in
                                res1.start < res2.start
                            }))
                        {reservation in
                            let dateFormatted: String = selectedDate.formatted(date: .numeric, time: .omitted)
                            
                            //filters available reservations based on day and availability
                            if (availableRes && !reservation.reserved  && reservation.date == dateFormatted){
                                
                                let timePeriod: String = reservation.start + " - " + reservation.end
                                
                                //pass name in
                                NavigationLink {ResTimeView(
                                    name: currUser,
                                    courtNum: courtNum,
                                    time: timePeriod,
                                    date: selectedDate.formatted(date: .complete, time: .omitted),
                                    id:reservation.id)}
                                label: {
                                    Text("Court \(reservation.court) | \(timePeriod)")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50)
                                        .background(CustomColor.myColor)
                                        .cornerRadius(10)
                                        .padding(.bottom, 10)
                                }
                            
                            }
                            
                            //filter and display current reservations
                            if (!yourResExist && !availableRes && reservation.reserved  && reservation.date == dateFormatted && reservation.player != currUser){
                                let timePeriod: String = reservation.start + " - " + reservation.end
                                
                                Text("Court \(reservation.court): \(reservation.player) | \(timePeriod)")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 375, height: 50)
                                    .background(CustomColor.myColor)
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)

                            }
                            
                            //filter and display your reservations
                            if (yourResExist && !availableRes && reservation.reserved  && reservation.date == dateFormatted && reservation.player == currUser){
                                let timePeriod: String = reservation.start + " - " + reservation.end
                                
                                
                                //change to new view of deleting page
                                
                                NavigationLink {
                                    
                                    DeleteResView(
                                    name: currUser,
                                    courtNum: courtNum,
                                    time: timePeriod,
                                    date: selectedDate.formatted(date: .complete, time: .omitted),
                                    id:reservation.id)}
                                label: {
                                    Text("Court \(reservation.court) | \(timePeriod)")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50)
                                        .background(CustomColor.myColor)
                                        .cornerRadius(10)
                                        .padding(.bottom, 10)
                                }

                            }
                            
                            
                        }
                    }
                    
                }
            }
        }
        //When the screen appears, the data is fetched
        //Note: the default court is court 1
        .onAppear() {
            self.resVM.fetchRes(courtNum: courtNum)
            Task{
                            try? await profileVM.loadCurrentUser()
            }
        }
    }
    
}




struct ResTimeView: View {
    
    @ObservedObject var resVM = ResViewModel()
    
    @State var name = ""
    @State var email = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    @State var id = ""
    
    //call view model to get current user
    //@ObservedObject var profileVM = ProfileViewModel()
    
    
    var body: some View{
        //let currUser = profileVM.user?.name
        
        //NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                
                Image("Logo")
                    .padding()
                
                Text("\(name.components(separatedBy: " ")[0]), do you want to reserve Court \(courtNum)?")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.horizontal,10)
                    .padding()
                
                
                Text("\(date)")
                    .font(.headline)
                
                Text("\(time)")
                    .font(.headline)
                    .padding()
                
                
//                // Player's name
//                TextField("Name", text: $name)
//                    .autocorrectionDisabled(true)
//                    .autocapitalization(.none)
//                    .padding()
//                    .frame(width:300, height:50)
//                    .background(Color.black.opacity(0.05))
//                    .cornerRadius(10)
//                    .padding()

            
                //Button to confirm reservation
                //Switches views and writes to the database
                NavigationLink {
                    ResConfirmationView(name: name, courtNum:courtNum, time: time, date:date)
                        .onAppear{
                            //writes to the database
                            resVM.makeRes(id: id, player: name, courtNum: courtNum)

                        }
                }
            label: {
                Text("Confirm Reservation")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    .padding(.top, 10)
            }
                
                
            }
//            .onAppear(){
//                Task{
//                        try? await profileVM.loadCurrentUser()
//                }
//                print("2: \(currUser)")
//            }
        }
    //}
    
}

//Shows that reservation has been confirmed
//Will add confirmation email capability
struct ResConfirmationView: View{
    
    @State var name = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    
    
    
    var body: some View{
        
            VStack {
                Image("Logo")
                    .padding()
                
                
                Text("Reservation Confirmed!")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("\(name.components(separatedBy: " ")[0]), your reservation for \(time) on \(date) at Court \(courtNum ) has been confirmed.")
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal,10)
                    .padding()
                                
                
                //After user closes the confirmation screen, they will be brought back to the Calendar screen
                //Note: need to ensure that CalendarView is the root view and users cannot navigate back to previous screens after closing
                NavigationLink {CalendarResView().navigationBarBackButtonHidden(true)}
            label: {
                Text("Close")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .navigationBarBackButtonHidden(true)
                
            }
            }
    }
}

struct DeleteResView: View{
    //include name?
    
    @ObservedObject var resVM = ResViewModel()
    
    @State var name = ""
    @State var email = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    @State var id = ""
    
    
    var body: some View{
        //NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                
                Image("Logo")
                    .padding()
                
                // Include more info - day, time, court, name,etc.
                Text("\(name.components(separatedBy: " ")[0]), do you want to delete your reservation?")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.horizontal,10)
                    .padding()
                
                Text("Court \(courtNum)")
                    .font(.headline)
                
                Text("\(date)")
                    .font(.headline)
                
                Text("\(time)")
                    .font(.headline)
                    .padding()
                

            
                //Button to confirm reservation
                //Switches views and writes to the database
                NavigationLink {
                    DeleteResConfirmationView(name:name, courtNum:courtNum, time: time, date:date)
                        .onAppear{
                            //updates to the database
                            resVM.deleteRes(id: id, courtNum: courtNum)

                        }
                }
            label: {
                Text("Delete Reservation")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    .padding(.top, 10)
            }
                
                
            }
        }
    //}
}

struct DeleteResConfirmationView: View{
    
    @State var name = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    
    var body: some View{
 
            VStack {
                Image("Logo")
                    .padding()
                
                
                Text("Reservation Deleted")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("\(name), your reservation for \(time) on \(date) at Court \(courtNum ) has been deleted.")
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal,10)
                    .padding()
                                
                
                //After user closes the confirmation screen, they will be brought back to the Calendar screen
                //Note: need to ensure that CalendarView is the root view and users cannot navigate back to previous screens after closing
                NavigationLink {CalendarResView().navigationBarBackButtonHidden(true)}
            label: {
                Text("Close")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .navigationBarBackButtonHidden(true)
                
            }
            }

    }
}


#Preview {
    CalendarResView()
}

