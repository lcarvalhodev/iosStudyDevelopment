import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeControllerWith(addAcount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAcount)
    }
}
