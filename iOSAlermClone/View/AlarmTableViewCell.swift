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
//    let selectColror = UIColor(red: 25, green: 25, blue: 25)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = stateSwitch
        
//        selectBackGroundView.backgroundColor = selectColror
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
        self.descriptionLabel.text = "\(listAlarmModel.description),\(listAlarmModel.repeatState ?? "")"
        self.stateSwitch.isOn = listAlarmModel.isOnState
        let checkMark = UIImageView(image: UIImage(systemName: "chevron.right"))
        self.editingAccessoryView = checkMark
    }
    @objc func setColor()
    {
        self.timeLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
        self.descriptionLabel.textColor = (stateSwitch.isOn) ? .white : .lightGray
    }
    
}

