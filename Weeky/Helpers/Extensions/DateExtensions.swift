//
//  DateExtensions.swift
//  Weeky
//
//  Created by Екатерина Кондратьева 
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func showOnlyTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
   //MARK: = date to string
    func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


extension String {
// MARK: Преобразование строки в дату
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    var extractedName: String {
        let pattern = "\"([^\"]+)\""
        if let range = self.range(of: pattern, options: .regularExpression) {
            return String(self[range].dropFirst().dropLast())
        }
        return ""
    }
}


