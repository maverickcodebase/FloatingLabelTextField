//
//  FocusablePadding.swift
//  FloatingLabelTextField
//
//  Created by Sheraz Ahmed on 15/06/2024.
//

import SwiftUI

// MARK: - View Extension
extension View {
    /// Adds focusable padding to a view, making the entire padded area tappable to focus
    /// - Parameters:
    ///   - edges: The edges to apply padding to
    ///   - size: The size of the padding
    /// - Returns: A view with focusable padding
    func focusablePadding(_ edges: Edge.Set = .all, _ size: CGFloat? = nil) -> some View {
        modifier(FocusablePadding(edges: edges, size: size))
    }
}

// MARK: - FocusablePadding Modifier
private struct FocusablePadding: ViewModifier {
    // MARK: - Properties
    private let edges: Edge.Set
    private let size: CGFloat?
    @FocusState private var focused: Bool
    
    // MARK: - Initializer
    init(edges: Edge.Set, size: CGFloat?) {
        self.edges = edges
        self.size = size
    }
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .focused($focused)
            .padding(edges, size)
            .contentShape(Rectangle())
            .onTapGesture {
                focused = true
            }
    }
}
