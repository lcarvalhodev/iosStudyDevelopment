import XCTest
import Main
import Presentation
import UI
import Validation

final class SignUpControllerFactoryTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, addAcountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAcountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_compose_with_correct_validations() throws {
        let validations = makeSignUpValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Name"))
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
        XCTAssertEqual(validations[4] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "passwordConfirmation", fieldNameToCompare: "password", fieldLabel: "Password Confirmation"))
    }
}

extension SignUpControllerFactoryTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy){
        let addAcountSpy = AddAccountSpy()
        let sut = makeSignUpControllerWith(addAccount: MainQueueDispatchDecorator(addAcountSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAcountSpy, file: file, line: line)
        return (sut, addAcountSpy)
    }
}
