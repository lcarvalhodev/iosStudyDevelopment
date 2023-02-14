import XCTest
import Main
import Presentation
import UI

final class SignUpComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy){
        let addAcountSpy = AddAccountSpy()
        let sut = SignUpComposer.composeControllerWith(addAccount: addAcountSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAcountSpy, file: file, line: line)
        return (sut, addAcountSpy)
    }
}
