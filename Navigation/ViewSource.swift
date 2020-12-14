//
//  ViewSource.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation
import SwiftUI

public final class ViewSource: ObservableObject {
    @Published public private(set) var next: AnyView?
    public private(set) var closeHandler: PresentingView.Handler?
    
    public init() {}
    
    public func setup<V>(
        presentedView: V?,
        closeHandler: @escaping PresentingView.Handler
    ) where V: View {
        self.closeHandler = {
            closeHandler()
            self.clear()
        }
        self.next = AnyView(presentedView)
    }
    
    private func clear() {
        closeHandler = nil
        next = nil
    }
}
