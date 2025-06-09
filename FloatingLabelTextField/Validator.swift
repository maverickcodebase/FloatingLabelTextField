//
//  Validator.swift
//  Expense Ninja
//
//  Created by Sheraz Ahmed on 16/06/2024.
//

import Foundation


func isValidEmail(_ email: String) -> Bool {
    // Implement your email validation logic here
    guard !email.isEmpty else {
        return false
    }
    
    let str = email.removeWhiteSpaces()
    let regExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
    return predicate.evaluate(with: str)
}



 func isValidPassword(_ password: String) -> Bool {
     // Check if password is not empty
     guard !password.isEmpty else {
         return false
     }
     
     let regExpression = "^(?=.*?[A-Z])(?=.*?\\d).{8,}$"
     let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
     return predicate.evaluate(with: password)
 }
 
extension String {
   
    /// Removes all whitespace characters from the string.
    func removeWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
