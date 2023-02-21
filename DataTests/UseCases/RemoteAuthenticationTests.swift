import Foundation
import XCTest
import Domain
import Data

final class RemoteAuthenticationTests: XCTestCase {
    
    func test_add_shoud_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth()
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
}

extension RemoteAuthenticationTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAuthentication, HttpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
    }
}

