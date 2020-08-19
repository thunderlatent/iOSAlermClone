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
    let selectBackGroundView = UIView()
    var stateSwitch = UISwitch()
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = stateSwitch
        selectBackGroundView.backgroundColor = UIColor(red: 25, green: 25, blue: 25)
        stateSwitch.addTarget(self, action: #selector(self.setColor), for: .valueChanged)
        self.selectedBackgroundView = selectBackGroundView
        // Initialization code
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
   
    func setUp(listAlarmModel:AlarmModel)
    {
        self.timeLabel.text = listAlarmModel.times
        self.descriptionLabel.text = listAlarmModel.description
        self.stateSwitch.isOn = listAlarmModel.isOnState
        
    }
    @objc func setColor()
    {
        self.timeLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
        self.descriptionLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
    }
    
}

