//
//  Copyright (c) 2021. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Combine
import Foundation
import SwiftUI

public protocol ViewableRouting: Routing {
    var erasedView: AnyView { get }
}

/// The base class of all routers that owns view controllers, representing application states.
///
/// A `Router` acts on inputs from its corresponding interactor, to manipulate application state and view state,
/// forming a tree of routers that drives the tree of view controllers. Router drives the lifecycle of its owned
/// interactor. `Router`s should always use helper builders to instantiate children `Router`s.

open class ViewableRouter<InteractorType, ViewControllerType: ViewControllable, Content: View>: Router<InteractorType>, ViewableRouting {
    public var erasedView: AnyView { AnyView(view) }

    public var childrenViews: [AnyView] {
        children
            .compactMap { $0 as? ViewableRouting }
            .map(\.erasedView)
    }
    
    public var view: Content

    /// The corresponding `ViewController` owned by this `Router`.
    public let viewControllable: ViewControllerType

    /// Initializer.
    ///
    /// - parameter interactor: The corresponding `Interactor` of this `Router`.
    /// - parameter viewController: The corresponding `ViewController` of this `Router`.
    public init(
        interactor: InteractorType,
        viewControllable: ViewControllerType,
        view: inout Content
    ) {
        self.viewControllable = viewControllable
        self.view = view
        super.init(interactor: interactor)
    }
}
