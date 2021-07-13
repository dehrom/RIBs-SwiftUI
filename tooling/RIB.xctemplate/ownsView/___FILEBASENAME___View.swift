//___FILEHEADER___

import SwiftUI
import Navigator

struct ___VARIABLE_productName___View: View {
    @ObservedObject var viewController: ___VARIABLE_productName___ViewController

    var body: some View {
        Text("Hello, I am ___VARIABLE_productName___ view")
    }

    @Environment(\.navigator) private var navigator
}

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(viewController: ___VARIABLE_productName___ViewController())
    }
}
