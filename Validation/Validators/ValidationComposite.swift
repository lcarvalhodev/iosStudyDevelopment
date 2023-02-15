import Foundation
import Presentation

public class ValidationComposite: Validation {
    
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        
        for validation in validations {
            if let errorMsg = validation.validate(data: data) {
                return errorMsg
            }
        }
        return nil
    }
}
