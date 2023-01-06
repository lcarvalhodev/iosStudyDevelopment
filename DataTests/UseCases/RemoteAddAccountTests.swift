import XCTest
import Domain
import Data

final class RemoteAddAccountTests: XCTestCase {
    
    func test_add_shoud_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAcountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_shoud_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAcountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, HttpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAcountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", confirmPassword: "any_password")
    }
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
