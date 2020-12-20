//
//  PresentableInteractor.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation

/// Base class of an `Interactor` that actually has an associated `Presenter` and `View`.
open class PresentableInteractor<PresenterType>: Interactor {
    /// The `Presenter` associated with this `Interactor`.
    public let presenter: PresenterType

    /// Initializer.
    ///
    /// - note: This holds a strong reference to the given `Presenter`.
    ///
    /// - parameter presenter: The presenter associated with this `Interactor`.
    public init(presenter: PresenterType) {
        self.presenter = presenter
    }
}
