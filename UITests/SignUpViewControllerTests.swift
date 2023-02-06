import XCTest
import UIKit
import Presentation
@testable import UI

final class SignUpViewControllerTests: XCTestCase {

    func test_leading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_is_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_is_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView )
    }
}

extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded ()
        return sut
    }
}
