//
//  Date+Extensions.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

extension Date {
    static func calculateDate(date: Date, day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -day, to: date)!
    }
    
    enum DateFilterSelection {
        case lastDay, lastTwoDays, lastThreeDays, lastWeek, lastMonth
        var selectedDate: Date {
            switch self {
            case .lastDay:
                return Date.calculateDate(date: Date(), day: 1)
            case .lastTwoDays:
                return Date.calculateDate(date: Date(), day: 2)
            case .lastThreeDays:
                return Date.calculateDate(date: Date(), day: 3)
            case .lastWeek:
                return Date.calculateDate(date: Date(), day: 7)
            case .lastMonth:
                return Date.calculateDate(date: Date(), day: 30)
            
            }
        }
    }
    
    
    static func getMaxDate(dateSelection: DateFilterSelection) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: dateSelection.selectedDate)
    }
    
    static func getMinDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
