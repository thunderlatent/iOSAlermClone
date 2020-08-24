//
//  Protocol.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/24.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
protocol PassingValueDelegate:AnyObject {
    func passingValue(alarmData: AlarmModel)
    func reloadTableView()
}
