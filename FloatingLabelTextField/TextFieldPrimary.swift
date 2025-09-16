//
//  TextFieldPrimary.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 09/06/2025.
//

import SwiftUI

// MARK: - TextFieldPrimary
/// A custom text field with floating label, icon support, and validation
struct TextFieldPrimary: View {
    // MARK: - Properties
    @Binding var text: String
    let placeholder: String
    let icon: String?
    let isSecureField: Bool
    let validationType: ValidationType
    
    @State private var isValid: Bool = true
    @State private var iconScale: CGFloat = 1.0
    @FocusState private var isFocused: Bool
    @State private var isSecureTextEntry: Bool = true
    
    // MARK: - Initializer
    init(
        text: Binding<String>,
        placeholder: String,
        icon: String? = nil,
        isSecureField: Bool = false,
        validationType: ValidationType = .optional
    ) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isSecureField = isSecureField
        self.validationType = validationType
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            inputField
            
            if !isValid {
                errorMessage
            }
        }
    }
    
    // MARK: - Input Field
    private var inputField: some View {
        ZStack(alignment: .leading) {
            HStack {
                if let icon = icon {
                    Image(icon)
                }
                
                if isSecureField {
                    secureTextField
                } else {
                    regularTextField
                }
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .padding(.all)
            .focused($isFocused)
            .disableAutocorrection(true)
            .font(.subheadline)
            .accentColor(Color(.main))
            .overlay(borderOverlay)
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
            .onChange(of: text) { _, _ in
                validate()
            }
            .onSubmit {
                validate()
            }
            
            placeHolder
                .padding(.horizontal)
        }
    }
    
    // MARK: - Border Overlay
    private var borderOverlay: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(borderColor, lineWidth: 1)
    }
    
    // MARK: - Border Color
    private var borderColor: Color {
        if isFocused {
            return Color(.main)
        } else if isValid {
            return Color(.border)
        } else {
            return Color(.red)
        }
    }
    
    // MARK: - Placeholder
    private var placeHolder: some View {
        Text(placeholder)
            .foregroundStyle(placeholderColor)
            .padding(.horizontal, 2)
            .background(Color(.systemBackground))
            .offset(x: placeholderXOffset, y: placeholderYOffset)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1.0), value: isFocused)
            .font(.subheadline)
            .onTapGesture {
                isFocused = true
            }
    }
    
    // MARK: - Placeholder Computed Properties
    private var placeholderColor: Color {
        isFocused || !text.isEmpty ? Color(.label) : Color(.placeholderText)
    }
    
    private var placeholderXOffset: CGFloat {
        icon == nil ? 0 : (isFocused || !text.isEmpty ? 0 : 28)
    }
    
    private var placeholderYOffset: CGFloat {
        isFocused || !text.isEmpty ? -28 : 0
    }
    
    // MARK: - Text Fields
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
    
    // MARK: - Secure Text Field Toggle
    private var secureTextfieldToggleView: some View {
        Image(isSecureTextEntry ? "eye-slash" : "eye")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .scaleEffect(iconScale)
            .onTapGesture {
                toggleSecureTextEntry()
            }
    }
    
    // MARK: - Secure Text Entry Toggle
    private func toggleSecureTextEntry() {
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
    
    // MARK: - Error Message
    private var errorMessage: some View {
        Text(validationType.errorMessage)
            .font(.caption2)
            .foregroundStyle(Color(.red))
    }
    
    // MARK: - Validation
    private func validate() {
        guard validationType.requiresValidation else {
            isValid = true
            return
        }
        
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



// MARK: - Preview
#Preview {
    VStack {
        TextFieldPrimary(
            text: .constant(""),
            placeholder: "Email",
            icon: "mail"
        )
        TextFieldPrimary(
            text: .constant(""),
            placeholder: "Password",
            icon: "lock",
            isSecureField: true
        )
    }
    .padding()
}
