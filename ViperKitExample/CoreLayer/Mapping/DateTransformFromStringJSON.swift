//
//  DateTransformFromStringJSON.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransformStringJson: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateformatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            return dateformatter.date(from: timeStr)
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        dateformatter.timeZone = .current
        if let date = value {
            return dateformatter.string(from: date)
        }
        return nil
    }
}
