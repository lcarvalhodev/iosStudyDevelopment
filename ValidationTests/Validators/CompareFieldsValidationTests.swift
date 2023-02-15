import XCTest
import Presentation
import Validation

final class CompareFieldsValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_comparation_fails() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let errorMsg = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMsg, "Password field is invalid.")
    }
    
    func test_validate_should_return_error_if_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password Confirmation")
        let errorMsg = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMsg, "Password Confirmation field is invalid.")
    }
    
    func test_validate_should_return_nil_if_comparation_succeeds() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let errorMsg = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(errorMsg)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let errorMsg = sut.validate(data: nil)
        XCTAssertEqual(errorMsg, "Password field is invalid.")
    }
}


extension CompareFieldsValidationTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
