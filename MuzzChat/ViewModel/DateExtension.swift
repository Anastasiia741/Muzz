//  Extension.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import Foundation

extension Date {
    
    func descriptiveStringForChat(dateStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Accesses.posix)
        let daysBetween = self.daysBetween(date: Date())
        switch daysBetween {
        case 0:
            formatter.dateFormat = Texts.today
        case 1:
            formatter.dateFormat = Texts.yesterday
        case 2...6:
            formatter.dateFormat = Texts.week
        default:
            formatter.dateStyle = dateStyle
        }
        return formatter.string(from: self)
    }
    
    func descriptiveStringForChats(dateStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        let daysBetween = self.daysBetween(date: Date())
        switch daysBetween {
        case 0:
            return Texts.todayMain
        case 1:
            return Texts.yesterdayMain
        case 2...6:
            formatter.dateFormat = Texts.week
            return formatter.string(from: self)
        default:
            return formatter.string(from: self)
        }
    }
    
    func daysBetween(date: Date) -> Int {
        let calendar = Calendar.current
        let startOfDayForSelf = calendar.startOfDay(for: self)
        let startOfDayForDate = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfDayForSelf, to: startOfDayForDate)
        return abs(components.day ?? 0)
    }
}
