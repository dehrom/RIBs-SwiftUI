//
//  Builder.swift
//  RIBs
//
//  Created by Valery Kokanov on 24/07/2019.
//

import Foundation

/// The base builder protocol that all builders should conform to.
public protocol Buildable: AnyObject {}

/// Utility that instantiates a RIB and sets up its internal wirings.
open class Builder<DependencyType>: Buildable {
    /// The dependency used for this builder to build the RIB.
    public let dependency: DependencyType

    /// Initializer.
    ///
    /// - parameter dependency: The dependency used for this builder to build the RIB.
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}
