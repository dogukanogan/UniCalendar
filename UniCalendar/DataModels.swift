
import Foundation
import SwiftData

// Lesson model
@Model
class Lesson {
    var id: UUID
    var name: String
    var classroom: String
    var dayOfWeek: Int // 1:mon 2:tues
    var startTime: Date
    var endTime: Date
    var color: String // lessons color, hex code
    var notes: String // lesson specific notes
    
    init(name: String, classroom: String, dayOfWeek: Int, startTime: Date, endTime: Date, color: String = "#007AFF", notes: String = "") {
        self.id = UUID()
        self.name = name
        self.classroom = classroom
        self.dayOfWeek = dayOfWeek
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
        self.notes = notes
    }
}

// HW/Project model
@Model
class Assignment {
    var id: UUID
    var title: String
    var details: String
    var dueDate: Date
    var isCompleted: Bool
    
    init(title: String, details: String, dueDate: Date, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.details = details
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}

