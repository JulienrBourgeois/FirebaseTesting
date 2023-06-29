//
//  ContentView.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        Group
        {
            if viewModel.userSession == nil
            {
                LoginView()
            }
            else
            {
                ProfileView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
