import Foundation
import Domain

public final class LoginPresenter {
    
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication) {
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
        else {
            authentication.auth(authenticationModel: viewModel.toAuthenticationModelModel()) { [weak self] result in
                guard let self = self else {return}
                   switch result {
                       case .failure(let error):
                           var errorMessage: String!
                               switch error{
                                   case .expiredSession: errorMessage = "Email and/or password invalid."
                                   default: errorMessage = "Unexpected error. Try again."
                               }
                           self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: errorMessage))
                       case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Successfully Login."))
                }
            }
        }
    }
}
