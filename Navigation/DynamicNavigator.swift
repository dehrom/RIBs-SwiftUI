//
//  DynamicNavigator.swift
//  RIBs
//
//  Created by Valery Kokanov on 19.12.2020.
//

import SwiftUI

public final class DynamicNavigationController: ObservableObject {
    @Published var pushingView: AnyView? = nil
    
    public init() {}
    
    public func push(
        _ view: AnyView,
        callback: @escaping () -> Void
    ) {
        pushingView = view
        pushCallback = { [self] in
            pop()
            callback()
            pushCallback = nil
        }
    }
    
    public func pop() {
        pushingView = nil
    }
    
    var pushCallback: (() -> Void)?
}

public struct DynamicNavigator: View {
    public init(
        controller: DynamicNavigationController,
        content: @escaping @autoclosure () -> AnyView
    ) {
        self.controller = controller
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            content()
            
            controller
                .pushingView
                .map {
                    NavigationLink(
                        destination: CloseHandlingView(content: $0, callback: controller.pushCallback),
                        isActive: .constant(true)
                    ) { EmptyView() }
                }
        }
    }
    
    @ObservedObject private var controller: DynamicNavigationController
    private let content: () -> AnyView
}

struct CloseHandlingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let callback: (() -> Void)?
    
    init(
        content: AnyView,
        callback: (() -> Void)?
    ) {
        self.callback = callback
        self.content = content
    }
    
    public var body: some View {
        content
            .onDisappear {
                guard presentationMode.wrappedValue.isPresented == false else { return }
                callback?()
            }
    }
    
    private let content: AnyView
}
