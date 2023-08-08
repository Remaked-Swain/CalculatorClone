//
//  CalendarManager.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/07.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    
    private let formatter: DateFormatter
    
    private init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        self.formatter = formatter
    }
    
    func dateToString(_ date: Date) -> String {
        return formatter.string(from: date)
    }
    
    func stringToDate(timestamp: String) -> Date? {
        return self.formatter.date(from: timestamp)
    }
    
    func differenceInDays(from: String, to: String) -> Int? {
        guard let start = stringToDate(timestamp: from), let end = stringToDate(timestamp: to) else {
            return nil
        }
            
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        return components.day
    }
    
    func showUTCTime(_ exchangeRateModel: ExchangeRateModel) -> String {
        guard let timestamp = exchangeRateModel.timeLastUpdateUTC else { return "Timestamp 옵셔널 해제 불가." }
        guard let date = stringToDate(timestamp: timestamp) else { return "Date 변환 실패." }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        return formatter.string(from: date)
    }
}
