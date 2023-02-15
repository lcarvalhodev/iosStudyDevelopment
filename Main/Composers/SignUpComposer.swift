import Foundation
import Domain
import UI
import Presentation
import Validation

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: <#T##Validation#>)
        controller.signUp = presenter.signUp
        return controller
    }
}
