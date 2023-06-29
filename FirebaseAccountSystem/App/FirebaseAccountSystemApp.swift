//
//  FirebaseAccountSystemApp.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import SwiftUI
import Firebase

@main
struct FirebaseAccountSystemApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init()
    {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
