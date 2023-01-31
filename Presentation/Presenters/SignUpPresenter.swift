import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount) {
        self.emailValidator = emailValidator
        self.alertView = alertView
        self.addAccount = addAccount
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel){
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
        else {
            let addAccountModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, confirmPassword: viewModel.passwordConfirmation!)
            addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
                guard let self = self else {return}
                switch result {
                    case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Unexpected error. Try again."))
                    case .success: break
                }
            }
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
            return "Field password confirmation is invalid"
        }
        else if(!emailValidator.isValid(email: viewModel.email!)){
            return "Field email is invalid"
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
