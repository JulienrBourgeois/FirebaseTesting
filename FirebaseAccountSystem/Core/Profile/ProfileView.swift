//
//  ProfileView.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser
        {
            List
            {
                Section
                {
                    HStack
                    {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4)
                        {
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .tint(Color.gray)
                        }
                    }
                    
                }
                
                Section("General")
                {
                    HStack
                    {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color.gray)
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account")
                {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    
                    Button {
                        print("Delete account")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                    
                }
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
