//
//  User.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/27/23.
//

import Foundation

struct User: Identifiable, Codable
{
    let id : String
    let fullName : String
    let email : String
    
    var initials : String
    {
        let formatter = PersonNameComponentsFormatter()
        
        if let componenets = formatter.personNameComponents(from: fullName)
        {
            formatter.style = .abbreviated
            return formatter.string(from: componenets)
        }
       
        return ""
    }
}



extension User
{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "test@gmail.com")
}
