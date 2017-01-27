//
//  ChartAxisValueDate.swift
//  swift_charts
//
//  Created by ischuetz on 01/03/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

open class ChartAxisValueDate: ChartAxisValue {
    
    fileprivate let formatter: (Date) -> String
    private var isUppercased = false
    
    open var date: Date {
        return ChartAxisValueDate.dateFromScalar(scalar)
    }
    
    public init(date: Date, formatter: @escaping (Date) -> String, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.formatter = formatter
        super.init(scalar: ChartAxisValueDate.scalarFromDate(date), labelSettings: labelSettings)
    }
    
    convenience public init(date: Date, formatter: DateFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings(), isUppercased: Bool = false) {
        self.init(date: date, formatter: { formatter.string(from: $0) }, labelSettings: labelSettings)
        self.isUppercased = isUppercased
    }
    
    open class func dateFromScalar(_ scalar: Double) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(scalar))
    }
    
    open class func scalarFromDate(_ date: Date) -> Double {
        return Double(date.timeIntervalSince1970)
    }
    
    // MARK: CustomStringConvertible
    
    override open var description: String {
        if self.isUppercased {
            return formatter(date).uppercased()
        } else {
            return formatter(date)
        }
    }
    
    open override func copy(_ scalar: Double) -> ChartAxisValue {
        return ChartAxisValueDate(date: ChartAxisValueDate.dateFromScalar(scalar), formatter: formatter, labelSettings: labelSettings)
    }
}

