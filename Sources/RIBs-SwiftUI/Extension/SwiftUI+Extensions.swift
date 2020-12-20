//
//  SwiftUI+Extensions.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation
import SwiftUI

/// View extensions.
public extension View {
    /// Erase type of the view.
    var any: AnyView { .init(self) }
}
