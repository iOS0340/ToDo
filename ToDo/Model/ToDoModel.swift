//
//  ToDoModel.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import Foundation

enum Status : Codable {
    case todo
    case inprogress
    case done    
};

class ToDoModel : Identifiable, Codable {
    var id = UUID()
    var title : String
    var description: String
    var status : Status
    var date : String
    
    init(id: UUID = UUID(), title: String, description: String, status: Status, date: String) {
        self.id = id
        self.title = title
        self.description = description
        self.status = status
        self.date = date
    }
}
