//
//  RepeatTableViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/13.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class RepeatTableViewController: UITableViewController {
    var selectDaysOfWeek: [Int:String] = [:]
    var numberToString = ["日","一","二","三","四","五","六",]
    var allDays = Set(Days.allCases)
    var select: Set<Days> = []
    var showRepeatText = "永不"
    override func viewDidLoad() {
        super.viewDidLoad()
        showText()
    }

    // MARK: - Table view data source
    //設置section0的背景顏色
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let blackView:UIView =
        {
            let blackView = UIView()
            blackView.backgroundColor = .black
            return blackView
        }()
        return blackView
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allDays.count
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = (select.contains(Days(rawValue: indexPath.row)!)) ? .checkmark : .none
        tableView.backgroundColor = .black
        let selectBackGroundView: UIView = {
            let selectView = UIView()
            selectView.backgroundColor = UIColor(red: 80, green: 80, blue: 80)
            
            return selectView
        }()
        cell.selectedBackgroundView = selectBackGroundView
    }
    
    //MARK: TableViewDelegate -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRows(tableView: tableView, indexPath: indexPath)
        
    }
    func selectRows(tableView:UITableView, indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
//        selectDaysOfWeek[indexPath.row] = (selectDaysOfWeek[indexPath.row] == nil) ? numberToString[indexPath.row] : nil
//        cell?.accessoryType = (selectDaysOfWeek[indexPath.row] != nil) ? .checkmark : .none
        
        
        let cell = tableView.cellForRow(at: indexPath)

        if select.contains(Days(rawValue: indexPath.row)!)
        {
            select.remove(Days(rawValue: indexPath.row)!)
        }else
        {
            select.insert(Days(rawValue: indexPath.row)!)
        }
        
        cell?.accessoryType = (select.contains(Days(rawValue: indexPath.row)!)) ? .checkmark : .none
        
        
        showText()
    }
    
    func showText()
    {
        switch select {
        case [.sunday,.saturday]:
            self.showRepeatText = "週末"
        case [.monday,.tuesday,.wednesday,.thursday,.friday]:
            self.showRepeatText = "平日"
        case []:
            self.showRepeatText = "永不"
        case Set(Days.allCases):
            self.showRepeatText = "每天"
        default:
            let text = select.sorted(by: { (raw1, raw2) -> Bool in
                return raw1.rawValue < raw2.rawValue
            }).map { (day) -> String in
                "週\(day.dayString) "
            }.joined(separator: " ")
            
            showRepeatText = text
        }
        print(showRepeatText)
    }
   
}
