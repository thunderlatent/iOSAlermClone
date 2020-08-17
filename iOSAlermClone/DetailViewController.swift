//
//  DetailViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var barTitle: UILabel!
    weak var delegate: PassingValueDelegate?
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    var alarmModel: AlarmModel!
    var inDetailTableViewController: InDetailTableViewController!
    lazy var selectTime = nowTime
    var nowTime: String
    {
        let now = Date()
                let dateformatter = DateFormatter()
                // 設定時間格式
                dateformatter.dateFormat = "HH:mm"
                // 將時間轉換成字串
                let nowTime = dateformatter.string(from: now)
                print("現在時間：\(nowTime)")
        return nowTime
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimePicker()
        setBarItemTitle()
        getSelectTimeToString()
        setDataToInDetailTableViewcontroller()
        navigationItem.backBarButtonItem?.tintColor = UIColor.systemOrange
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
            }
    override func viewDidAppear(_ animated: Bool) {
        
        print("alarmModel:\(alarmModel)")
   
    }
    func setBarItemTitle()
    {
        navigationItem.title = (alarmModel == nil) ? "加入鬧鐘" : "編輯鬧鐘"
    }
    func setupTimePicker()
    {
        self.timePicker.locale = Locale(identifier: "en_GB")
        self.timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        print("test")
    }
    
    func getNowTimeToString() -> String
    {
        let now = Date()
                let dateformatter = DateFormatter()
                // 設定時間格式
                dateformatter.dateFormat = "HH:mm"
                // 將時間轉換成字串
                let nowTime = dateformatter.string(from: now)
                print("現在時間：\(nowTime)")
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
        print("selectTime:\(selectTime)")
        let date = dateFormatter.date(from: alarmModel.times)
        print("date:\(date!)")
        return date!
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let inDetailTBC = segue.destination as? InDetailTableViewController {
            inDetailTableViewController = inDetailTBC
            
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
 
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        dismiss(animated: true) {
            print("點選按鈕時的時間：\(self.getSelectTimeToString())")
            self.tapToSaving()
        }
    }
    @objc func timePickerAction(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.selectTime = formatter.string(from: sender.date)
        print("sender.date:\(selectTime)")
    }
    
    func tapToSaving()
    {
        alarmModel = AlarmModel(times: selectTime, description: inDetailTableViewController.descriptionLabel.text!, isOnState: true, repeatState: inDetailTableViewController.repeatLabel.text, laterMinder: inDetailTableViewController.laterMinderSwitch.isOn, ring: inDetailTableViewController.ringLabel.text)
        delegate?.passingValue(alarmData: alarmModel)
        
    }
    func setDataToInDetailTableViewcontroller()
    {
        if let alarmModel = alarmModel
        {
//            timePicker.date = getStringToSelectTime()
            print("getStringToSelectTime:\(getStringToSelectTime())")
            timePicker.setDate(getStringToSelectTime(), animated: false)
            inDetailTableViewController.repeatLabel.text = alarmModel.repeatState
            inDetailTableViewController.descriptionLabel.text = alarmModel.description
            inDetailTableViewController.ringLabel.text = "漣漪"
            inDetailTableViewController.laterMinderSwitch.isOn = alarmModel.isOnState
            print("alarmModel.description:\(alarmModel.description)")
        }
    }
    
    deinit {
        print("被釋放")
        print(alarmModel ?? "NIL")
    }
}
