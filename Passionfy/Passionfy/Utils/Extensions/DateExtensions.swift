//
//  DateExtensions.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import Foundation

extension Date {

    var age: Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year ?? 0
    }
    
    func timeAgo() -> String {
        let calendar = Calendar.current
        let now = Date()
            
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: now)
            
        if let year = components.year, year > 0 {
            return "\(year) year\(year > 1 ? "s" : "") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month > 1 ? "s" : "") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day > 1 ? "s" : "") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour > 1 ? "s" : "") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute > 1 ? "s" : "") ago"
        } else if let second = components.second, second > 0 {
            return "\(second) second\(second > 1 ? "s" : "") ago"
        } else {
            return "Just now"
        }
    }
    
    func formatString(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
