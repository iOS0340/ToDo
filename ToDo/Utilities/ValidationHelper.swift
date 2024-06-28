//
//  ValidationHelper.swift
//  ToDo
//
//  Created by Bhavesh Patel on 25/06/24.
//

import Foundation

enum ValidationType: Equatable {
    case success
    case fail(String)
}

final class ValidationHelper {
    static var shared : ValidationHelper {
        return ValidationHelper()
    }
    
    func validateTitle (title : String?) -> ValidationType {
        guard let title = title, !title.isEmpty else {
            return .fail(kTitleValidationMessage)
        }
        return .success
    }
    
    func validationDescription (description : String?) -> ValidationType {
        guard let description = description, !description.isEmpty else {
            return .fail(kDescriptionValidationMessage)
        }
        return .success
    }
    
}
