//
//  DateGenerator.swift
//  WeiXinSportNew
//
//  Created by randy on 16/3/22.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class DateGenerator: NSObject {
    class func genDates()->[String]
    {
        let today = NSDate()
        var datesString:[String] = [String]()
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: today)
        print(range)
        let day = calendar.components(.Day, fromDate: today)
        let month = calendar.components(.Month, fromDate: today)
        if day.day - 7 > 0
        {
            let first = day.day - 7
            for var i = first+1;i<=day.day;i++
            {
                if i == first+1
                {
                    let dateString = String(format:"%d月%d",month.month,i)
                    datesString.append(dateString)
                }
                else
                {
                    let dateString = String(i)
                    datesString.append(dateString)
                }
            }
        }
        return datesString
    }
}
