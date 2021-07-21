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

public protocol Plugin: Any {
    associatedtype Context
    associatedtype Component = Dependency
    associatedtype Listener /* Interactable */

    var killswitchName: String { get }

    func isApplicable(with context: Context) -> AnyPublisher<Bool, Never>

    func build(with component: Component, and listener: Listener) -> Routing
}

public extension Plugin {
    func eraseToAnyPlugin() -> AnyPlugin<Context, Component, Listener> {
        AnyPlugin(concrete: self)
    }
}

public extension Plugin where Context == () {
    func isApplicable(with context: Context) -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
}

public final class AnyPlugin<Context, Component, Listener>: Plugin {
    public let killswitchName: String

    init<P: Plugin>(concrete: P) where P.Context == Context, P.Component == Component, P.Listener == Listener {
        killswitchName = concrete.killswitchName
        _isApplicable = concrete.isApplicable
        _build = concrete.build
    }

    public func isApplicable(with context: Context) -> AnyPublisher<Bool, Never> {
        _isApplicable(context)
    }

    public func build(with component: Component, and listener: Listener) -> Routing {
        _build(component, listener)
    }

    private let _isApplicable: (Context) -> AnyPublisher<Bool, Never>
    private let _build: (Component, Listener) -> Routing
}

extension AnyPlugin: Equatable, Hashable {
    public static func == (lhs: AnyPlugin, rhs: AnyPlugin) -> Bool {
        lhs.killswitchName == rhs.killswitchName
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(killswitchName.hashValue)
    }
}
