//
//  AlarmModel.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/11.
//  Copyright © 2020 yuming. All rights reserved.
//
				
import UIKit

struct AlarmModel:Codable,Equatable {
    var times: String = "00:00"
    var description = "鬧鐘"
    var isOnState = false
    var repeatState: String? = "永不"
    var laterMinder: Bool? = true
    var ring: String? = "漣漪"
    var selectDays: Set<Days>? = []
}
