//
//  CloseHandlingView.swift
//  RIBs
//
//  Created by Valery Kokanov on 21.12.2020.
//

import SwiftUI

struct CloseHandlingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let content: AnyView
    let callback: () -> Void
    
    public var body: some View {
        content
            .onDisappear {
                guard
                    presentationMode.wrappedValue.isPresented == false
                else { return }
                callback()
            }
    }
    
}
