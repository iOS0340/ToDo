//
//  Helpers.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import Foundation
import UIKit

/**
 Method to get Text value for Task from status
 - Parameters:
 - status: Status: Status of Task selected by User.
 
 - Returns:
    -String: return respective string value of Status to store to the database.
 */

func getStatusText(status : Status) -> String {
    switch status {
    case .todo:
        return kToDo
    case .inprogress:
        return kInProgress
    case .done:
        return kDone
    }
}

/**
 Method to get Status value of Task from Text
 - Parameters:
 - status: String: Status of Task stored in Database.
 
 - Returns:
    -Status: return respective enum value of Status.
 */


func getStatusFromText(status : String) -> Status {
    switch status {
    case kToDo:
        return .todo
    case kInProgress:
        return .inprogress
    case kDone:
        return .done
    default:
        return .todo
    }
}

/**
    This method will return Toolbar to add input accessory view the given target.
        - Parameters:
           - selector: Selector: Selector call on button click
           - target: Any: Parent control in which Toolbar added as a input accessory view.
        - Returns:
            - UIToolbar: UIToolbar control with Done button.
 */

func addToolbarAccessoryView (selector : Selector, target : Any) -> UIToolbar {
    
    let bar = UIToolbar()
    let reset = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    bar.items = [flexibleSpace, reset]
    bar.sizeToFit()
    
    return bar
}

/**  Method to convert Date to String using Date Formatter
     - Parameters:-
            - date : Date - Date to convert to the string
*/
func convertDateToString (date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    formatter.timeZone = .current    
    return formatter.string(from: date)
}

/**
    Method to convert String to Date using Date Formatter
        - Parameters:
            - date: String - String to convert to Date
 */

func convertStringToDate (date : String) -> Date {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    formatter.timeZone = .current
    return formatter.date(from: date)!
}
