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

open class PluginizedRouter<Context, Component: Dependency, InteractorType, ViewControllerType: ViewControllable, Content: View>: ViewableRouter<InteractorType, ViewControllerType, Content> {

    public private(set) var plugins: Set<AnyPlugin<Context, Component, InteractorType>>

    public init(
        interactor: InteractorType,
        component: Component,
        viewController: ViewControllerType,
        view: LazyView<Content>
    ) {
        self.component = component
        plugins = []
        super.init(interactor: interactor, viewController: viewController, view: view)
    }

    public func applyPlugins(
        with context: Context,
        _ callback: @escaping ([(id: UUID, view: AnyView)]) -> ()
    ) {
        applyCancellation = Publishers.from(collection: plugins)
            .flatMap { [unowned self] in
                buildFrom($0, with: context)
            }
            .collect()
            .sink { [unowned self] routers in
                routers.forEach(attachChild)
                
                let views = routers
                    .compactMap { $0 as? ViewableRouting }
                    .map { ($0.id, $0.erasedView) }
                callback(views)
            }
    }

    public func addAndApplyPlugin<P: Plugin>(
        _ plugin: P,
        with context: Context,
        _ callback: @escaping (UUID, AnyView) -> ()
    ) where
        P.Component == Component,
        P.Context == Context,
        P.Listener == InteractorType
    {
        let anyPlugin = plugin.eraseToAnyPlugin()
        plugins.insert(anyPlugin)

        applyCancellation = buildFrom(anyPlugin, with: context)
            .sink { [unowned self] router in
                attachChild(router)

                if let view = (router as? ViewableRouting)?.erasedView {
                    callback(router.id, view)
                }
            }
    }
    
    public func isApplicableForAnyPlugin(_ context: Context) -> AnyPublisher<Bool, Never> {
        Publishers.from(collection: plugins)
            .flatMap {
                $0.isApplicable(with: context)
            }
            .first(where: { $0 })
            .replaceEmpty(with: false)
            .eraseToAnyPublisher()
    }

    public func addPlugin<P: Plugin>(_ plugin: P) where
        P.Component == Component,
        P.Context == Context,
        P.Listener == InteractorType
    {
        plugins.insert(plugin.eraseToAnyPlugin())
    }

    private let component: Component
    private var applyCancellation: AnyCancellable?
}

private extension PluginizedRouter {
    func buildFrom(
        _ plugin: AnyPlugin<Context, Component, InteractorType>,
        with context: Context
    ) -> AnyPublisher<Routing, Never> {
        plugin.isApplicable(with: context)
            .compactMap { $0 ? plugin : nil }
            .map { [unowned self] in
                $0.build(with: component, and: interactor)
            }
            .eraseToAnyPublisher()
    }
}
