import XCTest
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    public func isValid(email: String) -> Bool {
        let range  = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, range: range) != nil
    }
}

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
