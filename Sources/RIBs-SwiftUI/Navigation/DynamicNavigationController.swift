//
//  DynamicNavigationController.swift
//  RIBs
//
//  Created by Valery Kokanov on 21.12.2020.
//

import SwiftUI

public final class DynamicNavigationController: ObservableObject {
    @Published var modifier: ProxyModifier?
    
    public init() {}
    
    public func present(with style: PresentationStyle, onDismiss: @escaping () -> Void) {
        modifier = ProxyModifier(with: style) {
            self.modifier = nil
            onDismiss()
        }
    }
}

public enum PresentationStyle {
    case push(AnyView)
    case sheet(AnyView)
    case cover(AnyView)
}

public protocol ViewPresentable: ViewModifier {
    init(next: AnyView, onDismiss: @escaping () -> Void)
}

struct ProxyModifier: ViewModifier {
    init(with style: PresentationStyle, onDismiss: @escaping () -> Void) {
        self.style = style
        self.onDismiss = onDismiss
    }
    
    func body(content: Content) -> some View {
        switch style {
        case let .push(view):
            return content.modifier(PushViewPresenter(next: view, onDismiss: onDismiss)).any
        case let .sheet(view):
            return content.modifier(SheetViewPresenter(next: view, onDismiss: onDismiss)).any
        case let .cover(view):
            return content.modifier(CoverViewPresenter(next: view, onDismiss: onDismiss)).any
        }
    }
    
    private let style: PresentationStyle
    private let onDismiss: () -> Void
}

// MARK: - Presenters

struct PushViewPresenter: ViewPresentable {
    func body(content: Content) -> some View {
        content
            .overlay(
                NavigationLink(
                    destination: CloseHandlingView(content: next, callback: onDismiss),
                    isActive: .constant(true)
                ) { EmptyView() }
            )
    }
    
    let next: AnyView
    let onDismiss: () -> Void
}

struct CoverViewPresenter: ViewPresentable {
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                isPresented: .constant(true),
                onDismiss: onDismiss
            ) { self.next }
    }
    
    let next: AnyView
    let onDismiss: () -> Void
}

struct SheetViewPresenter: ViewPresentable {
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: .constant(true),
                onDismiss: onDismiss
            ) { self.next }
    }
    
    let next: AnyView
    let onDismiss: () -> Void
}
