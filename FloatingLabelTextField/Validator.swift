//
//  Validator.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 16/06/2024.
//

import Foundation

// MARK: - Email Validation
/// Validates email format using RFC 5322 compliant regex
/// - Parameter email: The email string to validate
/// - Returns: True if email format is valid, false otherwise
func isValidEmail(_ email: String) -> Bool {
    guard !email.isEmpty else { return false }
    
    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
    let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: trimmedEmail)
}

// MARK: - Password Validation
/// Validates password strength requirements
/// - Parameter password: The password string to validate
/// - Returns: True if password meets requirements (8+ chars, 1 uppercase, 1 digit), false otherwise
func isValidPassword(_ password: String) -> Bool {
    guard !password.isEmpty else { return false }
    
    let passwordRegex = #"^(?=.*[A-Z])(?=.*\d).{8,}$"#
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordPredicate.evaluate(with: password)
}

// MARK: - String Extensions
extension String {
    /// Removes all whitespace characters from the string
    /// - Returns: String with all whitespace characters removed
    func removeWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
