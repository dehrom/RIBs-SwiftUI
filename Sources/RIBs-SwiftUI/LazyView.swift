//
//  LazyView.swift
//  
//
//  Created by dehrom on 28.07.2021.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    public init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
    }
    
    private let content: () -> Content
}
