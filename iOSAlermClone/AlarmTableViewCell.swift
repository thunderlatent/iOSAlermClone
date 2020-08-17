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
    let stateSwitch = UISwitch()
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = stateSwitch
        selectBackGroundView.backgroundColor = UIColor(red: 25, green: 25, blue: 25)
        
        self.selectedBackgroundView = selectBackGroundView
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(time: String,  description: String, isOnState: Bool)
    {
        self.timeLabel.text = time
        self.descriptionLabel.text = description
        self.stateSwitch.isOn = isOnState
    }

}

