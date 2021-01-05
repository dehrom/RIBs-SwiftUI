//
//  NavigationProxyView.swift
//  RIBs
//
//  Created by Valery Kokanov on 19.12.2020.
//

import SwiftUI

public struct NavigationProxyView: View {
    public init(
        controller: DynamicNavigationController,
        content: @escaping @autoclosure () -> AnyView
    ) {
        self.controller = controller
        self.content = content
    }
    
    public var body: some View {
        if let modifier = controller.modifier {
            content()
                .modifier(modifier)
                .any
        } else {
            content()
        }
    }
    
    @ObservedObject private var controller: DynamicNavigationController
    private let content: () -> AnyView
}

