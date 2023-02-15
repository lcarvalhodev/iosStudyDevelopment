import XCTest
import Presentation
import Validation

final class RequiredFieldValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_field_is_not_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertEqual(errorMsg, "Email field is required.")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertEqual(errorMsg, "Idade field is required.")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMsg = sut.validate(data: ["email": "Leandro@mail.com"])
        XCTAssertNil(errorMsg)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMsg = sut.validate(data: nil)
        XCTAssertEqual(errorMsg, "Email field is required.")
    }
}


extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
