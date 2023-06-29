//
//  LoginView.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationStack
        {
            VStack
            {
                //image
                Image(systemName: "hammer")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                //input fields
                VStack(spacing: 24)
                {
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .textInputAutocapitalization(.never)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)

                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                //sign in button
                
                Button {
                    Task
                    {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack
                    {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
               

                Spacer()
                
                //sign up button
                NavigationLink {
                    //send to the sign up screen
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3)
                    {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }

            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol
{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.count <= 50
        && AuthenticationUtility().hasEmailFormat(string: email)
        && !password.isEmpty
        && password.count > 5
        && password.count <= 50
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
