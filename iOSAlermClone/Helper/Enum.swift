//
//  Enum.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/24.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
enum Days: Int, CaseIterable,Codable
{
    case sunday = 0,monday,tuesday,wednesday,thursday,friday,saturday
    var dayString: String
    {
        switch self {
        case .sunday:
            return "日"
        case .monday:
            return "一"
        case .tuesday:
            return "二"
        case .wednesday:
            return "三"
        case .thursday:
            return "四"
        case .friday:
            return "五"
        case .saturday:
            return "六"
        }
    }
}

