import XCTest
import Presentation

final class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "any_email", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation fails", message: "Field name should be provided"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation fails", message: "Field email should be provided"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation fails", message: "Field password should be provided"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation fails", message: "Field password confirmation should be provided"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password2")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation fails", message: "Field password confirmation should be equal to field password"))
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        let (sut, _, emailValidatorSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "invalid_email", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

}

extension SignUpPresenterTests {
    
    func makeSut () -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy){
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (sut, alertViewSpy,emailValidatorSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
            var isValid = true
            var email: String?
            func isValid(email: String) -> Bool {
                self.email = email
                return isValid
        }
    }
}
