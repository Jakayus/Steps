//
//  SettingsViewModel.swift
//  Steps
//
//  Created by Brittany Rima on 12/20/22.
//

import Foundation
import UserNotifications

class SettingsViewModel: ObservableObject {
    @Published var showingEditView = false
    @Published var notificationsOn = false

    func requestNotificationAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                if self.notificationsOn {
                    self.scheduleDailyNotification()
                } else {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
            }
        }
    }

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Good Morning!"
        content.body = "Try to reach your steps goal today. We believe in you!"

        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "daily-notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notifications: \(error.localizedDescription)")
            }
        }
    }
}
