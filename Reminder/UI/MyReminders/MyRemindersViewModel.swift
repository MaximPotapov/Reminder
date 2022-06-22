//
//  MyRemindersViewModel.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation

final class MyRemindersViewModel {
    let now = Date()
    let dateFormatter = DateFormatter()
    var reminderType: ReminderType = .noType
    var reminder: Reminder? = nil
    
    var months = ["Jun", "Jly", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May",]
    
    var dataSource: [Int: [Reminder]] = [1: [],
                                         2: [],
                                         3: [],
                                         4: [],
                                         5: [],
                                         6: [Reminder(name: "Dentist visit", date: 1655646240000, emoji: "🦷", repeatYearly: false, type: .other),
                                             Reminder(name: "Jay's birthday", date: 1657069200000, emoji: "🥳", repeatYearly: true, type: .birthday)],
                                         7: [],
                                         8: [],
                                         9: [Reminder(name: "Dentist visit", date: 1655646240000, emoji: "🦷", repeatYearly: false, type: .other)],
                                         10: [],
                                         11: [Reminder(name: "Deric's birthday", date: 1657069200000, emoji: "🥳", repeatYearly: true, type: .birthday)],
                                         12: []]
    
    
    func addReminder(name: String, date: String, emoji: String, repeatYearly: Bool, type: ReminderType, completion: @escaping () -> Void) {
        let day: Double = 60 * 60 * 24
        let currentDate = Date()
        guard let stringToInt = Int(date) else { return }
        // int to date
        // check if date in month
        
        switch type {
        case .birthday:
            reminderType = .birthday
            reminder?.emoji = "🎁"
        case .holiday:
            reminderType = .holiday
            reminder?.emoji = "🎉"
        case .other:
            reminderType = .other
        case .noType:
            reminderType = .noType
        }
        
        completion()
    }
}

