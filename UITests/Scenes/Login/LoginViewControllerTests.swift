import XCTest
import UIKit
import Presentation
@testable import UI

final class LoginViewControllerTests: XCTestCase {

    func test_leading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_is_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
}

extension LoginViewControllerTests {
    func makeSut() -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.loadViewIfNeeded ()
        return sut
    }
}
