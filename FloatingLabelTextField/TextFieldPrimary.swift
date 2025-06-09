//
//  TextFieldPrimary.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 09/06/2025.
//


import SwiftUI



struct TextFieldPrimary: View {
    @Binding var text: String
    var placeholder: String
    var icon: String?
    var isSecureField: Bool = false
    var validationType: ValidationType = .optional
    
    @State private var isValid: Bool = true
    @State private var iconScale: CGFloat = 1.0
    @FocusState private var isFocused: Bool
    @State private var isSecureTextEntry: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            inputField
            
            if !isValid {
                errorMessage
            }
        }
        
    }
    
    private var inputField: some View {
        
        ZStack(alignment: .leading) {
            
            HStack{
                Image(icon ?? "")
                Group{
                    
                    if isSecureField {
                        secureTextField
                    } else {
                        regularTextField
                    }
                }
                
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .focusablePadding(.all)
            .focused($isFocused)
            .disableAutocorrection(true)
            .font(.subheadline)
            .accentColor(Color(.main))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        isFocused ? Color(.main) : (isValid ? Color(.border) : Color(.red)),
                        lineWidth: 1
                    )
            ).onChange(of: text) {
                validate()
            }
            .onSubmit {
                validate()
            }
            
            
            placeHolder
                .padding(.horizontal)
        }
    }
    
    private var placeHolder: some View {
        Text(placeholder)
            .foregroundStyle(isFocused || !text.isEmpty ? Color(.label) : Color(.placeholderText))
            .padding(.horizontal,2)
            .background(Color(.systemBackground))
            .offset(x: (icon == nil) ? 0 : (isFocused || !text.isEmpty ? 0 : 28))
            .offset(y: isFocused || !text.isEmpty ? -28 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1.0), value: isFocused)
        
        
        
        
            .font(.subheadline)
            .onTapGesture {
                isFocused = true
            }
    }
    
    private var regularTextField: some View {
      
            TextField("", text: $text)
        
    }
    
    private var secureTextField: some View {
        ZStack {
            if isSecureTextEntry {
                SecureField("", text: $text)
            } else {
                regularTextField
            }
            
            secureTextfieldToggleView
            
        }
    }
    
    
    private var secureTextfieldToggleView: some View {
        Image(isSecureTextEntry ? "eye-slash" : "eye")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .scaleEffect(iconScale)
            .onTapGesture {
                withAnimation(.spring()) {
                    isSecureTextEntry.toggle()
                    iconScale = 1.1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        iconScale = 1.0
                    }
                }
            }
    }
    
    private var errorMessage: some View {
        Text(validationType.errorMessage)
            .font(.caption2)
            .foregroundStyle(Color(.red))
    }
    
    
    
    private func validate() {
        switch validationType {
        case .optional:
            isValid = true
        case .mandatory:
            isValid = !text.isEmpty
        case .email:
            isValid = isValidEmail(text)
        case .password:
            isValid = isValidPassword(text)
        case .confirmPassword(password: let password):
            isValid = text == password
        }
    }
}



#Preview {
    VStack{
        TextFieldPrimary(text: .constant(""),  placeholder: "Email", icon: "mail")
        TextFieldPrimary(text: .constant(""),  placeholder: "Password",icon: "lock", isSecureField: true)
    }
    .padding()
}
