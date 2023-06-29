//
//  RegistrationView.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    var body: some View {
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
                ZStack(alignment: .trailing)
                {
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .textInputAutocapitalization(.never)
                    
                    
                    if !email.isEmpty
                    {
                        if AuthenticationUtility().hasEmailFormat(string: email)
                            
                            && email.count <= 50
                        {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        }
                        else
                        {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                }
                
                ZStack(alignment: .trailing)
                {
                    InputView(text: $fullName, title: "Full Name", placeholder: "Enter your name")
                    
                    
                    if !fullName.isEmpty
                    {
                        if fullName.count >= 4 && fullName.count <= 50
                        {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        }
                        else
                        {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                }
                    
                ZStack(alignment: .trailing)
                {
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    
                    
                    if !password.isEmpty
                    {
                        if password.count >=  6 && password.count <= 50
                        {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        }
                        else
                        {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                    
                }
                
                ZStack(alignment: .trailing)
                {
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty && confirmPassword.count <= 50
                    {
                        if password == confirmPassword
                        {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        }
                        else
                        {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                    
                }
               

            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            //sign up button
            Button {
                Task
                {
                    try await viewModel.createUser(withEmail: email , password: password, fullName: fullName)
                }
            } label: {
                HStack
                {
                    Text("SIGN UP")
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
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3)
                {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }

        }
    }
}

extension RegistrationView: AuthenticationFormProtocol
{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && email.count <= 50
        && AuthenticationUtility().hasEmailFormat(string: email)
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && fullName.count <= 50
        && password.count <= 50
        && confirmPassword == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
