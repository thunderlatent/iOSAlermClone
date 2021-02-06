//
//  DetailViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK:- Properties
    weak var passingAlarmModelDelegate: PassingAlarmModelDelegate?
    var alarmModel: AlarmModel!

    var oldAlarmModel = AlarmModel()
    var inDetailTableViewController: InDetailTableViewController!
    var switchState = false
    lazy var selectTime:String =
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.selectTime = formatter.string(from: self.timePicker.date)
            return self.selectTime
        }()
    var nowTime: String
    {
        let now = Date()
        let dateformatter = DateFormatter()
        // 設定時間格式
        dateformatter.dateFormat = "HH:mm"
        // 將時間轉換成字串
        let nowTime = dateformatter.string(from: now)
        print("nowTime:\(nowTime)")
        return nowTime
    }
    
    //MARK:- UI Element
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimePicker()
        setBarItemTitle()
        getSelectTimeToString()
        setDataToInDetailTableViewcontroller()
        navigationItem.backBarButtonItem?.tintColor = UIColor.systemOrange
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let alarmModel = self.alarmModel
        {
            self.oldAlarmModel = alarmModel
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        isSwitchState()
        if let alarmModel = alarmModel
        {
            passingAlarmModelDelegate?.passingAlarmModel(alarmModel: alarmModel)
        }
        
    }
    //MARK:- override Function
    //MARK:- Custom Function
    
    func isSwitchState()
    {
        if let alarmModel = self.alarmModel
        {
            if alarmModel == oldAlarmModel
            {
                switchState = oldAlarmModel.isOnState
                self.alarmModel.isOnState = switchState
                
            }else
            {
                switchState = true
                self.alarmModel.isOnState = switchState
            }
        }
    }
    
    func setBarItemTitle()
    {
        navigationItem.title = (alarmModel == nil) ? "加入鬧鐘" : "編輯鬧鐘"
    }
    private func setupTimePicker()
    {
        //MARK: - 我要做24小時制，所以把時區轉換到英國
        self.timePicker.locale = Locale(identifier: "en_GB")
        
        //MARK: - 設置字體顏色
        self.timePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    private func getNowTimeToString() -> String
    {
        let now = Date()
        let dateformatter = DateFormatter()
        // 設定時間格式
        dateformatter.dateFormat = "HH:mm"
        // 將時間轉換成字串
        let nowTime = dateformatter.string(from: now)
        print("NowTime:\(nowTime)")
        return nowTime
    }
    
    func getSelectTimeToString() 
    {
        timePicker.addTarget(self, action: #selector(self.timePickerAction(_:)), for: .valueChanged)
        //        let getSelectTime = timpicker
    }
    func getStringToSelectTime() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: alarmModel.times)
        
        print("date:\(date)")
        return date!
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let inDetailTBC = segue.destination as? InDetailTableViewController
        {
            inDetailTableViewController = inDetailTBC
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        self.tapToSaving()
        dismiss(animated: true, completion: nil)
    }
    @objc func timePickerAction(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.selectTime = formatter.string(from: sender.date)
        
        print("sender.date:\(selectTime)")
    }
    
    private func tapToSaving()
    {
        
        alarmModel = AlarmModel(times: selectTime,
                                description: inDetailTableViewController.descriptionLabel.text!,
                                isOnState: switchState,
                                repeatState: inDetailTableViewController.repeatLabel.text,
                                laterMinder: inDetailTableViewController.laterMinderSwitch.isOn,
                                ring: inDetailTableViewController.ringLabel.text,
                                selectDays: inDetailTableViewController.select)
        
    }
    func setDataToInDetailTableViewcontroller()
    {
        if let alarmModel = alarmModel
        {
            timePicker.setDate(getStringToSelectTime(), animated: false)
            inDetailTableViewController.repeatLabel.text = alarmModel.repeatState
            inDetailTableViewController.descriptionLabel.text = alarmModel.description
            inDetailTableViewController.ringLabel.text = "漣漪"
            inDetailTableViewController.laterMinderSwitch.isOn = alarmModel.isOnState
            inDetailTableViewController.select = alarmModel.selectDays ?? []
        }
    }
    
    deinit {
        print("被釋放")
        print(alarmModel ?? "NIL")
    }
}
