//
//  ContentView.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 09/06/2025.
//

import SwiftUI


struct ContentView: View {
    
    
    @State var fullName = ""
    @State var email: String = ""
    @State var password: String = ""
    
    enum FouceField: Hashable {
        case fullName
        case email
        case password
    }
    
    @FocusState var focus: FouceField?
    
    
    
    var body: some View {
            VStack(spacing: 25){
                
                // MARK: - Logo
                Image(.maverickCodebase)
                    .resizable()
                    .scaledToFit()
                    .frame( height: 50)
                
            
                // MARK: - Header
                
                VStack {
                    Text("Welcome to Maverick Codebase 👋🏻")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Breaking the Code, Rewriting the rules")
                }
                
                
                // MARK: - Input Form
                
                VStack(alignment: .trailing, spacing: 16) {
                    
                    TextFieldPrimary(text: $fullName,
                                     placeholder: "Full Name",
                                     icon: "user",
                                     validationType: .mandatory)
                    .autocapitalization(.none)
                    .textContentType(.name)
                    .focused($focus, equals: .fullName)
                    .submitLabel(.next)
                    .onSubmit {
                        focus = .email
                    }
                    
                    TextFieldPrimary(text: $email,
                                     placeholder: "Email",
                                     icon: "mail",
                                     validationType: .email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focus = .password
                    }
                    
                    
                    TextFieldPrimary(text: $password,
                                     placeholder: "Password",
                                     icon: "lock",
                                     isSecureField: true,
                                     validationType: .password)
                    .autocapitalization(.none)
                    .textContentType(.password)
                    .focused($focus, equals: .password)
                    .onSubmit {
                        focus = .none
                    }
                    
                    
                }
                
                
                
                
                
                Spacer()
                
            }
            .padding()
            
            
            
        
    }
}
#Preview {
    
    ContentView()
    
}
