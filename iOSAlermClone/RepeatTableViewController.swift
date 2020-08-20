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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("selectDaysOfWeek:\(selectDaysOfWeek)")
        
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
        return 7
    }
    
    func selectRows(tableView:UITableView, indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        selectDaysOfWeek[indexPath.row] = (selectDaysOfWeek[indexPath.row] == nil) ? numberToString[indexPath.row] : nil
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = (selectDaysOfWeek[indexPath.row] != nil) ? .checkmark : .none
        print("SelectDaysOfWeek Count:\(selectDaysOfWeek.count)")
        print(selectDaysOfWeek)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = (selectDaysOfWeek[indexPath.row] != nil) ? .checkmark : .none
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
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
 
}
