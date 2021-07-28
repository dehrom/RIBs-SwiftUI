//___FILEHEADER___

import RIBs_SwiftUI

protocol ___VARIABLE_productName___Interactable: Interactable {
    var router: ___VARIABLE_productName___Routing? { get set }
    var listener: ___VARIABLE_productName___Listener? { get set }
}

protocol ___VARIABLE_productName___ViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ___VARIABLE_productName___Router<ViewControllable: ___VARIABLE_productName___ViewControllable>: ViewableRouter<___VARIABLE_productName___Interactable, ViewControllable, ___VARIABLE_productName___View> {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: ___VARIABLE_productName___Interactable, 
        viewController: ViewControllable,
        view: LazyView<___VARIABLE_productName___View>
    ) {
        super.init(interactor: interactor, viewController: viewController, view: view)
        interactor.router = self
    }
}

// MARK: - ___VARIABLE_productName___Routing

extension ___VARIABLE_productName___Router: ___VARIABLE_productName___Routing {}

// MARK: - Private functions

private extension ___VARIABLE_productName___Router {}
