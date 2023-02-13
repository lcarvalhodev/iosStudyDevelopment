import Foundation
import Domain
import UI

public final class SignUpComposer {
    static func composeControllerWith(addAcount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAcount)
    }
}
