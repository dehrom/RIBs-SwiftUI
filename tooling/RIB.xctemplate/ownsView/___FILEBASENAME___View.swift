//___FILEHEADER___

import SwiftUI
import Navigator

struct ___VARIABLE_productName___View: View {
    @ObservedObject var viewModel: ___VARIABLE_productName___ViewModel

    var body: some View {
        Text("Hello, I am ___VARIABLE_productName___ view")
    }

    @Environment(\.navigator) private var navigator
}

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(viewModel: ___VARIABLE_productName___ViewModel())
    }
}
