import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMsg: String?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMsg
    }
    
    func simulateError(){
        self.errorMsg = "Error"
    }
}
