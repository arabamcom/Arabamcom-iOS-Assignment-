//
//  FormatterManager.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

class FormatterManager {
    
    //MARK: - Properties
    public static let shared = FormatterManager()
    
    //MARK: - Date Formatter
     func dateFormatterForRequest(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
   
    //MARK: - Number Formatter
     func numberFormatter(price: Int?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        guard let formattedPrice = formatter.string(from: price! as NSNumber) else {return ""}
        return "\(formattedPrice) TL"
    }
    
    //MARK: - Km Formatter
    func kmFormatter(km: String?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        guard let formattedKm = formatter.string(for: Int(km ?? "")) else {return ""}
        return "\(formattedKm) km"
    }
}
