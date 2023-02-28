import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(authentication: makeRemoteAuthentication())
}

public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), authentication: authentication)
    controller.login = presenter.login
    return controller
}


public func makeLoginValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().email().build() +
        ValidationBuilder.field("password").label("Password").required().build()
}
