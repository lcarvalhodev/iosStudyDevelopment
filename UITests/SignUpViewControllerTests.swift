import XCTest
import UIKit
@testable import UI

final class SignUpViewControllerTests: XCTestCase {

    func test_leading_is_hidden_on_start() throws {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded ()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
}
