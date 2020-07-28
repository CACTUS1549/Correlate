//
//  Date+Ext.swift
//  Correlate
//
//  Created by Deepak Reddy on 28/07/20.
//  Copyright © 2020 Deepak Reddy. All rights reserved.
//

import Foundation

//Extending Date feature. This extension tells a week starts on Monday 12 AM.

extension Date{
    static func weekStartsOnMondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}
