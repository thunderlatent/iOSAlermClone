//
//  AlarmModel.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/11.
//  Copyright © 2020 yuming. All rights reserved.
//
				
import UIKit
protocol PassingValueDelegate:AnyObject {
    func passingValue(alarmData: AlarmModel)
    func reloadTableView()
}
struct AlarmModel:Codable,Equatable {
    var times: String = "00:00"
    var description = "鬧鐘"
    var isOnState = false
    var repeatState: String? = "永不"
    var laterMinder: Bool? = true
    var ring: String? = "漣漪"
    var selectDays: Set<Days>? = []
}
extension UITextField {
    func modifyClearButton(){
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "clear"), for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 60, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
}
}

extension UIColor
{
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat)
    {
        let red = red / 255
        let green = green / 255
        let blue = blue / 255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

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
