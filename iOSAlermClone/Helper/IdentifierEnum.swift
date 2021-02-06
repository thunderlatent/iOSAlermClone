//
//  CellIdentifierEnum.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2021/2/6.
//  Copyright © 2021 yuming. All rights reserved.
//

import Foundation
enum Identifier
{
    enum Cell
    {
        case alarmListCell
        
        var identifier: String
        {
            switch self
            {
            
            case .alarmListCell:
                return "alarmListCell"
            }
        }
    }
    enum Segue
    {
        case showDetail,showLabelVC,showRepeatTBC
        
        var identifier: String
        {
            switch self
            {
            
            case .showDetail:
                return "showDetail"
            case .showLabelVC:
                return "showLabelVC"
            case .showRepeatTBC:
                return "showRepeatTBC"
            }
            
        }
    }
}
