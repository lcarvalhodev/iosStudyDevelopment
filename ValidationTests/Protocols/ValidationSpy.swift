import Foundation
import Presentation

class ValidationSpy: Validation {
    
    var errorMsg: String?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMsg
    }
    
    func simulateError(_ errorMsg: String) {
        self.errorMsg = errorMsg
    }
}
