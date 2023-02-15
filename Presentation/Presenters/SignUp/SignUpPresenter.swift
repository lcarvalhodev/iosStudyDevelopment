import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView, addAccount: AddAccount, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
        else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
                guard let self = self else {return}
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                    case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Unexpected error. Try again."))
                    case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Account created."))
                }
            }
        }
    }
}
