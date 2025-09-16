//
//  ValidationType.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 23/06/2024.
//

import Foundation

// MARK: - Validation Types
/// Enum defining different validation types for text fields
enum ValidationType {
    case optional
    case mandatory
    case email
    case password
    case confirmPassword(password: String)
    
    /// Returns the appropriate error message for each validation type
    var errorMessage: String {
        switch self {
        case .optional:
            return ""
        case .mandatory:
            return "This field is required"
        case .email:
            return "Please enter a valid email address"
        case .password:
            return "Password must have at least 8 characters that include 1 uppercase character, 1 number"
        case .confirmPassword:
            return "Passwords do not match"
        }
    }
    
    /// Returns true if the validation type requires validation
    var requiresValidation: Bool {
        switch self {
        case .optional:
            return false
        default:
            return true
        }
    }
}
