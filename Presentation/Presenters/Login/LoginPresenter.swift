import Foundation
import Domain

public final class LoginPresenter {
    
    private let validation: Validation
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let authentication: Authentication
    
    public init(validation: Validation, alertView: AlertView, loadingView: LoadingView, authentication: Authentication) {
        self.validation = validation
        self.alertView = alertView
        self.loadingView = loadingView
        self.authentication = authentication
    }
    
    public func login(viewModel: LoginRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
        else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            authentication.auth(authenticationModel: viewModel.toAuthenticationModelModel()) { [weak self] result in
                guard let self = self else {return}
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
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
