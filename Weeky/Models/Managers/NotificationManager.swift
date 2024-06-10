//
//  NotificationManager.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

class NotificationManager{
    
    static let shared = NotificationManager()
    private var minutesBefore = -15
    
    func requestAuthorization(){
        let options:UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { sucess, error in
            if let error = error{
                print("Error: - \(error.localizedDescription)")
            }else{
                print("Success")
            }
        }
    }
    
    func scheduleNotification(task: Task) {
        
        let date = task.dateString.toDate()!.addingTimeInterval(TimeInterval(60 * minutesBefore))// Ваша дата

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        print("Год: \(components.year ?? 0)")
        print("Месяц: \(components.month ?? 0)")
        print("День: \(components.day ?? 0)")
        print("Часы: \(components.hour ?? 0)")
        print("Минуты: \(components.minute ?? 0)")
        print("Секунды: \(components.second ?? 0)")

        let dateComponents = DateComponents(year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)

        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "У вас скоро задача"
        content.body = task.title
        
        print(task.title, date, "\n")
        
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
