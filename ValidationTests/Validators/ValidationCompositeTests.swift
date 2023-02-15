import XCTest
import Presentation
import Validation

final class ValidationCompositeTests: XCTestCase {
    
    func test_validate_should_return_error_if_validation_fails() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError("Error 1")
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertEqual(errorMsg, "Error 1")
    }
    
    func test_validate_should_return_correct_error_message() throws {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2])
        validationSpy2.simulateError("Error 3")
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertEqual(errorMsg, "Error 3")
    }
    
    func test_validate_should_return_the_first_error_message() throws {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError("Error 2")
        validationSpy3.simulateError("Error 3")
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertEqual(errorMsg, "Error 2")
    }
    
    func test_validate_should_return_error_nil_validation_succeeds() throws {
        let sut = makeSut(validations: [ValidationSpy(), ValidationSpy()])
        let errorMsg = sut.validate(data: ["name": "Leandro"])
        XCTAssertNil(errorMsg)
    }
    
    func test_validate_should_call_validation_with_correct_data() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "Leandro"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests  {
    func makeSut(validations: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
