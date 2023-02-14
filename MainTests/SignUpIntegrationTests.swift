import XCTest
import Main
import Presentation

final class SignUpIntegrationTests: XCTestCase {

    func test_ui_presentation_integration() throws {
        let sut = SignUpComposer.composeControllerWith(addAcount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
