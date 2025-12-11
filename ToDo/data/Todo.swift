//
//  Todo.swift
//  ToDo
//
//  Created by Hardik Mehta on 11/12/25.
//

import Foundation
import SwiftData

@Model
class Todo {
    var title: String
    var date: Date
    var isCompleted: Bool

    init(title: String, date: Date, isCompleted: Bool = false) {
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
