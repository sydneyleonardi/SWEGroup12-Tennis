//
//  CalendarView.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/4/23.
//

import SwiftUI
import UIKit
//import FSCalendar
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore


//Displays the root calendar view used to display reservations
struct CalendarView: View {
    
    //tracks date selected on calendar
    @State private var selectedDate: Date = Date()

    //VM Object
    @ObservedObject var resVM = ReservationsViewModel()
    
    //@State private var currentRes = false
    @State private var availableRes : Bool = true
    
    @State private var availableResExist : Bool = false
    @State private var currentResExist : Bool = false
    
    var body: some View {
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
                  
                        Button(action: { self.availableRes = true
                        }){
                            Text("Available Reservations")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 145, height: 45)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                        
                        Button(action: { self.availableRes = false
                        }){
                            Text("Current Reservations")
                        }
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 145, height: 45)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                    }
                    .onAppear(){
                        availableRes = true
                    }
                    .padding(.vertical)
                    
                    //Spacer()
                    
                    
                    //Displays calendar
                    DatePicker("Select Date", selection: $selectedDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal)
                    
                        //.padding(.vertical, 20)
                    

                    
                    
                    if (availableRes){
                        Text("Available Reservations")
                            .font(.headline)
                    }
                    else{
                        Text("Current Reservations")
                            .font(.headline)
                    }
                    
                    Spacer()
                    //reset availableRes with new dates?
                    

                    //pulls reservations from database and displays
                    ScrollView {
                        ForEach(resVM.reservations) {reservation in
                            var dateFormatted: String = selectedDate.formatted(date: .numeric, time: .omitted)
                            
                            //filters available reservations based on day and availability
                            if (availableRes && !reservation.reserved  && reservation.date == dateFormatted){
                                //availableResExist = true
                                var timePeriod: String = reservation.start + " - " + reservation.end
                                
                                
                                NavigationLink {ReservationTimeView(
                                    time: timePeriod,
                                    date: selectedDate.formatted(date: .complete, time: .omitted),
                                    id:reservation.id)}
                            label: {
                                Text("\(reservation.month)/\(reservation.day) | \(timePeriod)")
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
                            if (!availableRes && reservation.reserved  && reservation.date == dateFormatted){
                                var timePeriod: String = reservation.start + " - " + reservation.end
                                //currentResExist = true
                                
                                Text("\(reservation.player) | \(timePeriod)")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(CustomColor.myColor)
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)

                            }
                            
                        }
//                        //fix alignment
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                       
//                        
//                        if (availableRes && !currentResExist){
//                            Text("No reservations have been made for today.")
//                        }
//                        if (!availableRes && !availableResExist){
//                            Text("There are no reservations avaialable today.")
//                        }
                    }
                    
                }
            }
        }
        //When the screen appears, the data is fetched
        .onAppear() {
            self.resVM.fetchReservations()
        }
    }
    
}




struct ReservationTimeView: View {
    
    @ObservedObject var resVM = ReservationsViewModel()
    
    @State var name = ""
    @State var email = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    @State var id = ""
    let courts = ["1","2","3","4"]
    
    var body: some View{
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // Include day
                //
                Text("Reservation")
                    .font(.largeTitle)
                    .padding()
                
                Text("\(date)")
                    .font(.headline)
                
                Text("\(time)")
                    .font(.headline)
                    .padding()
                
                // Player's name
                TextField("Name", text: $name)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding()
                
                // Player's email address
                TextField("Email", text: $email)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding()
                
                // Court Number - switch to dropdown/scroll with available courts
                //Used for scaling to more than one court
                
//                TextField("Court", text: $courtNum)
//                    .autocorrectionDisabled(true)
//                    .autocapitalization(.none)
//                    .padding()
//                    .frame(width:300, height:50)
//                    .background(Color.black.opacity(0.05))
//                    .cornerRadius(10)
//                    .padding()
                
                //need to filter the court numbers from db
                Picker("Select court", selection: $courtNum) {
                    ForEach(courts, id: \.self) {
                        Text("Court \($0)")
                            
                    }
                }
                .pickerStyle(.menu)
                .tint(.black)
                
                
                
                //Button to confirm reservation
                //Switches views and writes to the database
                NavigationLink {
                    ReservationConfirmationView(name:name, email:email, courtNum:courtNum, time: time, date:date)
                        .onAppear{
                            //writes to the database
                            resVM.makeReservations(id: id, player: name, email: email) //add courtNum to scale

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
        }
    }
    
}

//Shows that reservation has been confirmed
//Will add confirmation email capability
struct ReservationConfirmationView: View{
    @State private var path = NavigationPath()
    
    @State var name = ""
    @State var email = ""
    @State var courtNum = ""
    @State var time = ""
    @State var date = ""
    
    var body: some View{
        
        NavigationStack {
            VStack {
                Image("Logo")
                    .padding()
                
                
                Text("Reservation confirmed!")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("\(name), your reservation for \(time) on \(date) has been confirmed.")
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal,10)
                    .padding()
                
                //To scale: add more courts
                
                //        Text("\(name), your reservation for \(time) on \(date) at Court \(courtNum) has been confirmed.")
                //            .multilineTextAlignment(.center)
                //            .bold()
                //            .padding(.horizontal,10)
                //            .padding()
                
                Text("A confirmation email has been sent to you at \(email).")
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal,10)
                    .padding()
                
                
                //After user closes the confirmation screen, they will be brought back to the Calendar screen
                NavigationLink {CalendarView().navigationBarBackButtonHidden(true)}
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
}



#Preview {
    CalendarView()
}
