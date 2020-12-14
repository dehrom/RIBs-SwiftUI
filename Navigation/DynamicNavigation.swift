//
//  DynamicNavigation.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation
import SwiftUI

public struct DynamicNavigation: ViewModifier {
    @ObservedObject public internal(set) var viewSource: ViewSource
    
    public init(viewSource: ViewSource) {
        self.viewSource = viewSource
    }
    
    public func body(content: Content) -> some View {
        content.overlay(
            viewSource
                .next
                .map {
                    NavigationLink(
                        "",
                        destination: $0.overlay(PresentingView(closeHandler: viewSource.closeHandler)),
                        tag: 0,
                        selection: .constant(0)
                    )
                }
        )
    }
}
