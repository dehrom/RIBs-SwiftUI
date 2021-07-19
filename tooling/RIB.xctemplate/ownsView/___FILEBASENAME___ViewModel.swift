//___FILEHEADER___

import Combine
import Foundation
import SwiftUI

protocol ___VARIABLE_productName___PresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ___VARIABLE_productName___ViewModel: ObservableObject, ___VARIABLE_productName___ViewControllable {
    weak var listener: ___VARIABLE_productName___PresentableListener?
}

extension ___VARIABLE_productName___ViewModel: ___VARIABLE_productName___Presentable {}
