//
//  Component.swift
//  
//
//  Created by Valery Kokanov on 24/07/2019.
//

import Foundation

/// The base class for all components.
///
/// A component defines private properties a RIB provides to its internal `ViewController`, `Interactor`, `Presenter` and
/// view units, as well as public properties to its child RIBs.
///
/// A component subclass implementation should conform to child 'Dependency' protocols, defined by all of its immediate
/// children.
open class Component<DependencyType>: Dependency {
    /// The dependency of this `Component`.
    public let dependency: DependencyType

    /// Initializer.
    ///
    /// - parameter dependency: The dependency of this `Component`, usually provided by the parent `Component`.
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
    
    /// Used to create a shared dependency in your `Component` sub-class. Shared dependencies are retained and reused
    /// by the component. Each dependent asking for this dependency will receive the same instance while the component
    /// is alive.
    ///
    /// - note: Any shared dependency's constructor may not switch threads as this might cause a deadlock.
    ///
    /// - parameter factory: The closure to construct the dependency.
    /// - returns: The instance.
    public final func shared<T>(key: String = #function, _ factory: () -> T) -> T {
        lock.lock()
        defer {
            lock.unlock()
        }

        if let instance = sharedInstances[key] as? T {
            return instance
        }

        let instance = factory()
        sharedInstances[key] = instance

        return instance
    }

    // MARK: - Private

    private var sharedInstances = [String: Any]()
    private let lock = NSRecursiveLock()
}

/// The special empty component.
open class EmptyComponent: EmptyDependency {
    /// Initializer.
    public init() {}
}
