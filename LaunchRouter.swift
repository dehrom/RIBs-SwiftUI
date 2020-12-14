//
//  LaunchRouter.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation
import SwiftUI

/// The root `Router` of an application.
public protocol LaunchRouting: ViewableRouting {
    /// Launches the router tree.
    func launch() -> AnyView
}

/// The application root router base class, that acts as the root of the router tree.
open class LaunchRouter<InteractorType, ViewType, ViewController>: ViewableRouter<InteractorType, ViewType, ViewController>, LaunchRouting where ViewType: View, ViewController: ViewControllable {
    /// Launches the router tree.
    public func launch() -> AnyView {
        interactable.activate()
        return view
    }
}
