//
//  ViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PassingValueDelegate {
  
    
    
    func passingValue(alarmData: AlarmModel)
    {
        if tapBtn == "編輯"
        {
            alarmModels[indexPath!.row] = alarmData
            alarmTableView.reloadRows(at: [indexPath!], with: .automatic)
        }else if tapBtn == "新增"
        {
            alarmModels.append(alarmData)
            alarmTableView.reloadData()
        }
    }
 
    var alarmModels = [AlarmModel]()
    
    var indexPath: IndexPath?
    var tapBtn = "編輯"
    
    @IBOutlet weak var alarmTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("現在有\(alarmModels.count)資料")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlarmTableViewCell
        let data = alarmModels[indexPath.row]
        cell.setup(time: data.times, description: data.description, isOnState: data.isOnState)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        tableView.isEditing.toggle()
        navigationItem.leftBarButtonItem?.title = "編輯"
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func editBtn(_ sender: UIBarButtonItem) {
        isEditing.toggle()
        alarmTableView.setEditing(isEditing, animated: true)
        sender.title = (isEditing) ? "完成" : "編輯"
        tapBtn = "編輯"
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
    
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        tapBtn = "新增"
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondNVC = segue.destination as! UINavigationController
        
        if tapBtn == "編輯"
        {
            if segue.identifier == "showDetail"
            {
                
                let detailVC = secondNVC.topViewController as! DetailViewController
                if let indexPath = indexPath, alarmModels.count > 0
                {
                    detailVC.alarmModel = alarmModels[indexPath.row]
                    detailVC.delegate = self
            }
            }
        }else if tapBtn == "新增"
        {
            if segue.identifier == "showDetail"
            {
//
//                    let detailVC = segue.destination as! DetailViewController
//
//
                let detailVC = secondNVC.topViewController as! DetailViewController
                detailVC.delegate = self

            }
            
        }
    }
    deinit {
        print("deinit")
    }
    
   
}




