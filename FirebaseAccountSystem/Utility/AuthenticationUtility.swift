//
//  AuthenticationUtility.swift
//  FirebaseAccountSystem
//
//  Created by Automatic AI, LLC on 6/28/23.
//

import Foundation
import SwiftUI

struct AuthenticationUtility
{
    func hasEmailFormat(string: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
           return emailPredicate.evaluate(with: string)
    }
}
