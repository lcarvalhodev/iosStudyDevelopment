import XCTest
import Presentation
import Validation

final class EmailValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMsg = sut.validate(data: ["email": "invalid_email@mail.com"])
        XCTAssertEqual(errorMsg, "Email field is invalid")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMsg = sut.validate(data: ["email": "invalid_email@mail.com"])
        XCTAssertEqual(errorMsg, "Email2 field is invalid")
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: EmailValidatorSpy())
        let errorMsg = sut.validate(data: ["email": "valid_email@mail.com"])
        XCTAssertNil(errorMsg)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
        let errorMsg = sut.validate(data: nil)
        XCTAssertEqual(errorMsg, "Email field is invalid")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
