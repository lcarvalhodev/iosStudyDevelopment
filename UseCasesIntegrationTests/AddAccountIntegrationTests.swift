import XCTest
import Data
import Infra
import Domain

final class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() throws {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url , httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Test Swift", email: "\(UUID().uuidString)@swift.com", password: "swift123", confirmPassword: "swift123")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel){ result in
            switch(result) {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
        let exp2 = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel){ result in
            switch result {
            case .failure(let error) where error == .emailInUse:
                 XCTAssertNotNil(error)
            default:
                XCTFail("Expect failure got \(result) instead")
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 10)
    }
}
