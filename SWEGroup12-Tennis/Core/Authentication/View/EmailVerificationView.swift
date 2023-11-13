//
//  EmailVerificationView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/12/23.
//

import SwiftUI

struct EmailVerificationView: View {
    @StateObject private var viewModel = EmailVerificationViewModel()
    @State private var alert = false
    @State private var resendAlert = false
    @State private var alertMessage = ""
    @State private var checkUser = false
    
    
    var body: some View {
        Text("Verifed Your Email?")
            .font(.headline)
            .padding(30)
        
        Button{
                Task{
                       do{
                           try await viewModel.checkVerification()
                           checkUser = true
                       }catch EmailVerificationViewModel.VerificationError.notVerified {
                           alert = true
                           alertMessage = "Email is not yet verified. Check your email again or resend verification email."
                       }catch{
                           alert = true
                           alertMessage = "Error checking for verification. Try again."
                       }
                   }
                   
               }label:{
                   Text("Verified!")
               }
               .padding(30)
               .frame(width:300, height:50)
               .background(CustomColor.myColor)
               .cornerRadius(10)
               .foregroundColor(.black)
               .alert(isPresented: $alert) {
                   Alert(title: Text("Verification Issue"),
                         message: Text(alertMessage),
                         dismissButton: .default(Text("OK")) {
                       alert = false
                   })
               }
               
               NavigationLink("", destination: CreateProfileView().navigationBarBackButtonHidden(true), isActive: $checkUser)
               
               
               Button{
                   Task{
                       do{
                           try await viewModel.resendVerification()
                           resendAlert = true
                       }catch{
                       }
                   }
                   
               }label:{
                  Text("Resend Email")
               }
               .padding(30)
               .frame(width:300, height:50)
               .background(CustomColor.myColor)
               .cornerRadius(10)
               .foregroundColor(.black)
               .alert(isPresented: $resendAlert) {
                   Alert(title: Text("Email Resent"),
                         message: Text("Verification Email has been resent to your email address"),
                         dismissButton: .default(Text("OK")) {
                       resendAlert = false
                   })
            }
        
        Spacer()
    }
}

#Preview {
    EmailVerificationView()
}
