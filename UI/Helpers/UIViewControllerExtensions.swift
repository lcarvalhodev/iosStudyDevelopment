import Foundation
import UIKit

extension UIViewController {
    public func hideKeyboardOnTap(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
}
