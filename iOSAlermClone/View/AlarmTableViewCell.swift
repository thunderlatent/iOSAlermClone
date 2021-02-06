//
//  alarmTableViewCell.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
//    lazy var testLabel:UILabel =
//    {
//        let label = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width  * 0.5, height: 10))
//        label.backgroundColor = .white
//        return label
//    }()
    let selectBackGroundView: UIView = {
        let selectView = UIView()
        selectView.backgroundColor = UIColor(red: 25, green: 25, blue: 25)
        return selectView
    }()
    var stateSwitch = UISwitch()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = stateSwitch
        
        stateSwitch.addTarget(self, action: #selector(self.setColor), for: .valueChanged)
        self.selectedBackgroundView = selectBackGroundView
        
       
    }

   
  
    
    func configure(alarmModel:AlarmModel, row: Int)
    {
        self.stateSwitch.tag = row

        self.timeLabel.text = alarmModel.times
        self.descriptionLabel.text = "\(alarmModel.description),\(alarmModel.repeatState ?? "")"
        self.stateSwitch.isOn = alarmModel.isOnState
        let checkMark = UIImageView(image: UIImage(systemName: "chevron.right"))
        self.editingAccessoryView = checkMark
        configureAlarmTextColor()
        showAlarmDescription(alarmModel: alarmModel)
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20 )

    }
    @objc func setColor()
    {
        self.timeLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
        self.descriptionLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
    }
    
    //MARK: - 設置備註欄的資訊
    private func showAlarmDescription(alarmModel: AlarmModel)
    {
        switch alarmModel.selectDays
        {
        case [.sunday,.saturday]:
            self.descriptionLabel.text = " \(alarmModel.description)，每個週末"
        case [.monday,.tuesday,.wednesday,.thursday,.friday]:
            self.descriptionLabel.text = "\(alarmModel.description)，每個平日"
        case []:
            self.descriptionLabel.text = alarmModel.description
        case Set(Days.allCases):
            self.descriptionLabel.text = "\(alarmModel.description)，每天"
        default:
            self.descriptionLabel.text = " \(alarmModel.description)， \(alarmModel.repeatState!)"
        }
    }
    private func configureAlarmTextColor() {
        //MARK: - 改變文字顏色
        if self.stateSwitch.isOn
        {
            self.timeLabel.textColor = .white
            self.descriptionLabel.textColor = .white
        }else
        {
            self.timeLabel.textColor = .lightGray
            self.descriptionLabel.textColor = .lightGray
        }
    }
}

