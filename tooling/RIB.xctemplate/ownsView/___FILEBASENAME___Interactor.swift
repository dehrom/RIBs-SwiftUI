//___FILEHEADER___

import Foundation
import Combine
import RIBs_SwiftUI

protocol ___VARIABLE_productName___Routing: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ___VARIABLE_productName___Presentable: Presentable {
    var listener: ___VARIABLE_productName___PresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ___VARIABLE_productName___Listener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ___VARIABLE_productName___Interactor: PresentableInteractor<___VARIABLE_productName___Presentable> {
    weak var router: ___VARIABLE_productName___Routing?
    weak var listener: ___VARIABLE_productName___Listener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ___VARIABLE_productName___Presentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

// MARK: - ___VARIABLE_productName___Interactable

extension ___VARIABLE_productName___Interactor: ___VARIABLE_productName___Interactable {}

// MARK: - ___VARIABLE_productName___PresentableListener

extension ___VARIABLE_productName___Interactor: ___VARIABLE_productName___PresentableListener {}

// MARK: - Private functions

private extension ___VARIABLE_productName___Interactor {}
