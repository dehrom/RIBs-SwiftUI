//
//  Interactor.swift
//  RIBs
//
//  Created by Valery Kokanov on 24/07/2019.
//

import Foundation
import Combine
import SwiftUI

/// Protocol defining the activeness of an interactor's scope.
public protocol InteractorScope: AnyObject {
    /// Indicates if the interactor is active.
    var isActive: Bool { get }
    
    /// The lifecycle of this interactor.
    ///
    /// - note: Subscription to this stream always immediately returns the last event. This stream terminates after
    ///   the interactor is deallocated.
    var isActiveStream: AnyPublisher<Bool, Never> { get }
}

/// The base protocol for all interactors.
public protocol Interactable: InteractorScope {
    /// Activate this interactor.
    ///
    /// - note: This method is internally invoked by the corresponding builder. Application code should never  explicitly
    ///   invoke this method.
    ///   But now it is required by design of SwiftUI.
    func activate()

    /// Deactivate this interactor.
    ///
    /// - note: This method is internally invoked by the corresponding builder. Application code should never explicitly
    ///   invoke this method.
    ///   But now it is required by design of SwiftUI.
    func deactivate()
}

/// An `Interactor` defines a unit of business logic that corresponds to a viewModel unit.
///
/// An `Interactor` has a lifecycle driven by its owner builder. When the corresponding view become appeared,
/// its interactor becomes active. And when the router is detached from its parent, its `Interactor` resigns
/// active.
///
/// An `Interactor` should only perform its business logic when it's currently active.
open class Interactor: Interactable {
    /// Indicates if the interactor is active.
    public final var isActive: Bool {
        return isActiveSubject.value
    }
    
    public var isActiveStream: AnyPublisher<Bool, Never> {
        return isActiveSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    /// Initializer.
    public init() {}
    
    /// Activate the `Interactor`.
    ///
    /// - note: This method is internally invoked by the corresponding builder. Application code should never explicitly
    ///   invoke this method.
    ///   But now it is required by design of SwiftUI.
    public final func activate() {
        guard isActive == false else { return }
        
        isActiveSubject.send(true)
        didBecomeActive()
    }
    
    /// The interactor did become active.
    ///
    /// - note: This method is driven by the attachment of this interactor's owner builder. Subclasses should override
    ///   this method to setup subscriptions and initial states.
    open func didBecomeActive() {
        // No-op
    }
    
    /// Deactivate this `Interactor`.
    ///
    /// - note: This method is internally invoked by the corresponding router. Application code should never explicitly
    ///   invoke this method.
    public final func deactivate() {
        guard isActive == true else { return }
        
        willResignActive()
        activenessCancallable.forEach { $0.cancel() }
        activenessCancallable = []
        isActiveSubject.send(false)
    }
    
    /// Callend when the `Interactor` will resign the active state.
    ///
    /// This method is driven by the detachment of this interactor's owner builder. Subclasses should override this
    /// method to cleanup any resources and states of the `Interactor`. The default implementation does nothing.
    open func willResignActive() {
        // No-op
    }
    
    deinit {
        if isActive {
            deactivate()
        }
        
        isActiveSubject.send(completion: .finished)
    }
    
    // MARK: - Private
    
    private let isActiveSubject = CurrentValueSubject<Bool, Never>(false)
    fileprivate var activenessCancallable: [AnyCancellable] = []
}

/// Interactor related `Cancellable` extensions.
public extension Cancellable {
    /// Disposes the subscription based on the lifecycle of the given `Interactor`. The subscription is disposed
    /// when the interactor is deactivated.
    ///
    /// - note: This is the preferred method when trying to confine a subscription to the lifecycle of an
    ///   `Interactor`.
    ///
    /// When using this composition, the subscription closure may freely retain the interactor itself, since the
    /// subscription closure is disposed once the interactor is deactivated, thus releasing the retain cycle before
    /// the interactor needs to be deallocated.
    ///
    /// If the given interactor is inactive at the time this method is invoked, the subscription is immediately
    /// terminated.
    ///
    /// - parameter interactor: The interactor to cancel the subscription based on.
    func cancelOnDeactivate(_ interactor: Interactor) {
        guard interactor.isActive == true else {
            cancel()
            print("Subscription immediately terminated, since \(interactor) is inactive.")
            return
        }
        store(in: &interactor.activenessCancallable)
    }
}
