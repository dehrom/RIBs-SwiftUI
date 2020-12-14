//
//  PresentingView.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import SwiftUI

public struct PresentingView: View {
    public typealias Handler = () -> Void
    
    public internal(set) var closeHandler: Handler?
    
    public init(closeHandler: PresentingView.Handler?) {
        self.closeHandler = closeHandler
    }
    
    public var body: some View {
        Text("")
            .hidden()
            .onChange(
                of: presentationMode.wrappedValue.isPresented
            ) { [closeHandler] in
                guard $0 == false else { return }
                closeHandler?()
            }
    }
    
    @Environment(\.presentationMode) private var presentationMode
}
