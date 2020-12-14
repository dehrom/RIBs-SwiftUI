//
//  ViewableRouting.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation
import Combine
import SwiftUI

/// The base protocol for all routers that own their own view.
public protocol ViewableRouting: Routing {
    /// The base view  associated with this `Router`.
    var view: AnyView { get }
}

open class ViewableRouter<InteractorType, ViewType, ViewController>: Router<InteractorType>, ViewableRouting where ViewType: View, ViewController: ViewControllable {
    public let view: AnyView
    
    /// The base `ViewController` associated with this `Router`.
    public let viewControllable: ViewController
    
    public init(
        interactor: InteractorType,
        viewControllable: ViewController,
        view: ViewType
    ) {
        self.view = view.any
        self.viewControllable = viewControllable
        super.init(interactor: interactor)
    }
}
