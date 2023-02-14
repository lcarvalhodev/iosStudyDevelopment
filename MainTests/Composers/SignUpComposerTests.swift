import XCTest
import Main
import Presentation

final class SignUpComposerTests: XCTestCase {

    func test_ui_presentation_integration() throws {
        let sut = SignUpComposer.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
