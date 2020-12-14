//
//  Dependency.swift
//  
//
//  Created by Valery Kokanov on 24/07/2019.
//

import Foundation

/// The base dependency protocol.
///
/// Subclasses should define a set of properties that are required by the module from the DI graph. A dependency is
/// typically provided and satisfied by its immediate parent module.
public protocol Dependency: AnyObject {}

/// The special empty dependency.
public protocol EmptyDependency: Dependency {}
