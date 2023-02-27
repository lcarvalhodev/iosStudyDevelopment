import XCTest
import UIKit
import UI

public final class WelcomeRouter {
    
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController){
        self.nav = nav
        self.loginFactory = loginFactory
    }
    
    public func goToLogin () {
        nav.pushViewController(loginFactory())
    }
}

class WelcomeRouterTests: XCTestCase {
    
    func test_goToLogin_call_nav_with_correct_vc() throws {
        let (sut,nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
}

extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let nav = NavigationController()
        let loginFactorySpy = LoginFactorySpy()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin)
        return (sut, nav)
    }
}

extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
}
