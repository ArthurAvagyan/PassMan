//
//  Date.swift
//  aaber
//
//  Created by Zara Davtyan on 11.12.20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

// MARK: - DateFormatter
extension DateFormatter {
	
	static var apiDateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		dateFormatter.locale = Locale(identifier: "en")
		dateFormatter.dateFormat = Date.DateFormat.api.rawValue
		return dateFormatter
	}
}

extension Date {
    
    enum DateFormat: String {
        
        case numericDate = "dd.MM.yyyy"
        case api = "yyyy-MM-dd HH:mm:ss"
		case apiFull = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
	
//	var daysUntil: Int {
//		Calendar.current.dateComponents([.day], from: Date(), to: self)
//	}
	
	var year: Int {
		Calendar.current.component(.year, from: self)
	}
	
    func formateString(as dateType: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = dateType.rawValue
        return dateFormatter.string(from: self)
    }
}

extension String {
	
	func formateDate(as dateType: Date.DateFormat) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en")
		
		dateFormatter.dateFormat = dateType.rawValue
		return dateFormatter.date(from: self)
	}
}
