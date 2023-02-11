import XCTest
import Presentation
import Validation

final class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "ll"))
        XCTAssertFalse(sut.isValid(email: "ll@"))
        XCTAssertFalse(sut.isValid(email: "ll@ll"))
        XCTAssertFalse(sut.isValid(email: "ll@ll."))
        XCTAssertFalse(sut.isValid(email: "@ll.com"))
    }
    
    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "leandro@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "leandro@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "leandro@hotmail.com.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter{
        return EmailValidatorAdapter()
    }
}
