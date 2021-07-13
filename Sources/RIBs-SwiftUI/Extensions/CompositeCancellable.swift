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

public final class CompositeCancellable {
    public var isCancelled: Bool

    var count: Int { subscriptions.count }

    public init() {
        isCancelled = false
        subscriptions = []
    }

    deinit {
        cancel()
    }

    private var subscriptions: Set<AnyCancellable>
}

public extension CompositeCancellable {
    func insert<C: Cancellable>(_ subscription: C) {
        guard isCancelled == false else {
            subscription.cancel()
            return
        }

        subscription.store(in: &subscriptions)
    }
}

extension CompositeCancellable: Cancellable {
    public func cancel() {
        guard isCancelled == false else { return }
        isCancelled = true
        subscriptions.forEach { $0.cancel() }
    }
}
