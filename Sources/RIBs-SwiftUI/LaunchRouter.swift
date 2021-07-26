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

import Foundation
import SwiftUI

/// The root `Router` of an application.
public protocol LaunchRouting: Routing {
    /// Launches the router tree.
    func launch() -> AnyView
}

/// The application root router base class, that acts as the root of the router tree.
open class LaunchRouter<InteractorType, ViewController, Content: View>: ViewableRouter<InteractorType, ViewController, Content>, LaunchRouting where ViewController: ViewControllable {
    /// Launches the router tree.
    public func launch() -> AnyView {
        interactable.activate()
        return AnyView(viewClosure())
    }
}
