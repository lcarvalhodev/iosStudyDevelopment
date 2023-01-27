import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.emailValidator = emailValidator
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel){
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if(viewModel.name == nil || viewModel.name!.isEmpty){
           return "Field name should be provided"
        }
        else if(viewModel.email == nil || viewModel.email!.isEmpty){
            return "Field email should be provided"
        }
        else if(viewModel.password == nil || viewModel.password!.isEmpty){
            return "Field password should be provided"
        }
        else if(viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty){
            return "Field password confirmation should be provided"
        }
        else if(viewModel.password != viewModel.passwordConfirmation){
            return "Field password confirmation should be equal to field password"
        }
        else if(!emailValidator.isValid(email: viewModel.email!)){
            return "Invalid email"
        }
        return nil
    }
}

public struct SignUpViewModel {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
