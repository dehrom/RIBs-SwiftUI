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
    /// The  view  associated with this `Router`.
    var view: AnyView { get }
    
    /// The navigation controller associated with this `Router`.
    var navigationController: DynamicNavigationController { get }
}

open class ViewableRouter<InteractorType, ViewController>: Router<InteractorType>, ViewableRouting where ViewController: ViewControllable {
    public let view: AnyView
    public let navigationController: DynamicNavigationController
    
    /// The base `ViewController` associated with this `Router`.
    public let viewControllable: ViewController
    
    public init(
        interactor: InteractorType,
        viewControllable: ViewController,
        view: AnyView
    ) {
        navigationController = .init()
        self.view = NavigationProxyView(controller: navigationController, content: view).any
        self.viewControllable = viewControllable
        super.init(interactor: interactor)
    }
}
