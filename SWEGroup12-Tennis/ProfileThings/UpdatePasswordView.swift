//
//  UpdatePasswordView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/18/23.
//

// when you update password you should be re-navigated to login page
import SwiftUI

struct UpdatePasswordView: View {
    @StateObject private var viewModel = UpdatePasswordViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showSettings = false

    var body: some View {
        VStack{

            Text("Update Your Password")
                .font(.headline)
                .padding(30)

            InputView(text:$viewModel.password, title: "New Password", isSecureField: true)
                .padding(.bottom, 5)

            ZStack(alignment: .trailing){
                InputView(text: $viewModel.confirmPassword, title: "Confirm Password", isSecureField: true)
                if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty
                {
                    if viewModel.password == viewModel.confirmPassword{
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGreen))
                            .padding(.trailing, 5)
                    } else{
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemRed))
                            .padding(.trailing, 5)
                    }
                }
            }
            .padding(.bottom, 20)

            // throw and catch errors
            Button{
                Task{
                    do{
                        try await viewModel.updatePassword()
                        viewModel.alert = true
                        print("Password Updated!")
                    }catch{
                        print(error)
                    }
                }
            }label:{
                Text("Update Password")
            }
            .padding(30)
            .frame(width:300, height:50)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .foregroundColor(.black)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("Password Updated"),
                      message: Text("Your password has been successfully updated"),
                      dismissButton: .default(Text("OK")) {
                    viewModel.alert = false
                    showSettings = true
                })
            }

            NavigationLink("", destination: SettingsView(), isActive: $showSettings)

            Spacer()


        }
    }
}

extension UpdatePasswordView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.password.isEmpty
        && !viewModel.confirmPassword.isEmpty
        && viewModel.password.count > 8
        && viewModel.password == viewModel.confirmPassword
    }
}


#Preview {
    UpdatePasswordView()
}
