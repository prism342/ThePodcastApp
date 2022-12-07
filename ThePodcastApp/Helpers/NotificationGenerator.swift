//
//  NotificationGenerator.swift
//  ThePodcastApp
//
//  Created by Sankeeth Naguleswaran on 2022-12-07.
//

import Foundation
import UserNotifications

class NotificationGenerator {
    static func generateNotification(title: String, description: String) {
        requestAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 5
        dateComponents.hour = 10
        dateComponents.minute = 20
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
               print("Error scheduling notification \(String(describing: error))")
           }
        }
    }
    
    static func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print("Error requesting authorization \(error)")
            }
        }
    }
}
