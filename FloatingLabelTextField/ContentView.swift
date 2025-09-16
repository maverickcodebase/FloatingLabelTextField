//
//  ContentView.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 09/06/2025.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    // MARK: - State Properties
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    
    // MARK: - Focus Field Enum
    enum FocusField: Hashable {
        case fullName
        case email
        case password
    }
    
    @FocusState private var focus: FocusField?
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 25) {
            logoSection
            headerSection
            inputFormSection
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Logo Section
    private var logoSection: some View {
        Image(.maverickCodebase)
            .resizable()
            .scaledToFit()
            .frame(height: 50)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack {
            Text("Welcome to Maverick Codebase 👋🏻")
                .font(.title2)
                .fontWeight(.medium)
            Text("Breaking the Code, Rewriting the rules")
        }
    }
    
    // MARK: - Input Form Section
    private var inputFormSection: some View {
        VStack(alignment: .trailing, spacing: 16) {
            fullNameField
            emailField
            passwordField
        }
    }
    
    // MARK: - Text Fields
    private var fullNameField: some View {
        TextFieldPrimary(
            text: $fullName,
            placeholder: "Full Name",
            icon: "user",
            validationType: .mandatory
        )
        .autocapitalization(.none)
        .textContentType(.name)
        .focused($focus, equals: .fullName)
        .submitLabel(.next)
        .onSubmit {
            focus = .email
        }
    }
    
    private var emailField: some View {
        TextFieldPrimary(
            text: $email,
            placeholder: "Email",
            icon: "mail",
            validationType: .email
        )
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
        .textContentType(.emailAddress)
        .focused($focus, equals: .email)
        .submitLabel(.next)
        .onSubmit {
            focus = .password
        }
    }
    
    private var passwordField: some View {
        TextFieldPrimary(
            text: $password,
            placeholder: "Password",
            icon: "lock",
            isSecureField: true,
            validationType: .password
        )
        .autocapitalization(.none)
        .textContentType(.password)
        .focused($focus, equals: .password)
        .onSubmit {
            focus = .none
        }
    }
}
// MARK: - Preview
#Preview {
    ContentView()
}
