//
//  Reminder.swift
//  InventoryApp
//
//  Created by Hui Lin on 27/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit
import UserNotifications

class Reminder {
    static public func scheduleReminder(item: String, date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formattedDate = formatter.string(from: date)
        
        let content = UNMutableNotificationContent()
        content.title = "You have items expiring!"
        content.body = "\(item) is expiring on \(formattedDate)."
        content.sound = .default
        content.badge = 1
        
        var dateInfo = DateComponents()
        let before = Calendar.current.date(byAdding: .day, value: -3, to: date)
        let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: before!)
        
        dateInfo.day = components.day!
        dateInfo.month = components.month
        dateInfo.year = components.year
        dateInfo.hour = 11
        dateInfo.minute = 42
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        print(dateInfo)
    }
    
    static public func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("Notifications permission granted.")
            } else {
                print("Notification permission error: \(error!)")
            }
        }
    }
}
