//
//  AuthViewModel.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol
{
    var formIsValid : Bool {get}
}

@MainActor
class AuthViewModel : ObservableObject
{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser : User?
    
    init()
    {
        self.userSession = Auth.auth().currentUser
        
        Task
        {
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws
    {
        do
        {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user //sets the session user to the one from firebase
            await fetchUser() //fetch the user data for show
        }
        catch
        {
            print("Debug: Error signing the user in \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws
    {
        print("Create User..")
        
        do
        {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
           
                self.userSession = result.user
            
            let user = User(id: result.user.uid, fullName: fullName, email: email)

            let encodedUser = try Firestore.Encoder().encode(user)
            
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            
            await fetchUser()
        }
        catch
        {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut()
    {
        do
        {
            try Auth.auth().signOut() //signs out user on back end
            self.userSession = nil //wipes out user session and takes us back to login screen
            self.currentUser = nil
        }
        catch
        {
            print("Debug: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    func deleteAccount()
    {
       
    }
    
    
    
    func fetchUser() async
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        
        self.currentUser = try? snapshot.data(as: User.self)
        
        
     
    }
    
    
}
