//
//  SingleCancellable.swift
//  RIBs
//
//  Created by Valery Kokanov on 13.11.2020.
//

import Foundation
import Combine

public typealias CancelablesSet = Set<AnyCancellable>

public final class SingleCancellable: Cancellable {
    public var cancellable: Cancellable? {
        willSet {
            cancellable?.cancel()
        }
    }
    
    public init() {}
    
    deinit {
        cancel()
    }
    
    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
}
