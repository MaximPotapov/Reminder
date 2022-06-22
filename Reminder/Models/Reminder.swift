//
//  Reminder.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation

struct Reminder {
    var name: String
    var date: Int
    var emoji: String
    var repeatYearly: Bool
    var type: ReminderType
}

enum ReminderType: String {
    case birthday = "Birthday"
    case holiday = "Holiday"
    case other = "Other"
    case noType
}
