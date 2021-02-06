//
//  ViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController,PassingAlarmModelDelegate {
    lazy var showNoAlarms:UILabel =
        {
            let label = UILabel(frame: CGRect(x: view.frame.width / 4, y: view.frame.height / 4, width: view.frame.width / 2, height: view.frame.height / 10))
            label.text = "無鬧鐘資料"
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont(descriptor: UIFontDescriptor(name: "system", size: 30), size: 30)
            label.backgroundColor = .black
            return label
        }()
    
    var alarmModels = [AlarmModel]()
    {
        didSet
        {
            self.setTableViewEmptyState()
            self.saveData()
        }
    }
    var indexPath: IndexPath?
    var tapBtn = "編輯"
    
    @IBOutlet weak var alarmTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        alarmTableView.addSubview(showNoAlarms)
        loadAlarmData()
        setTableViewEmptyState()
    }
    
    
    func setCellTextColor(cell:AlarmTableViewCell)
    {
        if cell.stateSwitch.isOn
        {
            cell.timeLabel.textColor = .white
            cell.descriptionLabel.textColor = .white
        }else
        {
            cell.timeLabel.textColor = .lightGray
            cell.descriptionLabel.textColor = .lightGray
        }
    }
    
    func showText(cell:AlarmTableViewCell, indexPath: IndexPath)
    {
        switch alarmModels[indexPath.row].selectDays
        {
        case [.sunday,.saturday]:
            cell.descriptionLabel.text = " \(alarmModels[indexPath.row].description)，每個週末"
        case [.monday,.tuesday,.wednesday,.thursday,.friday]:
            cell.descriptionLabel.text = "\(alarmModels[indexPath.row].description)，每個平日"
        case []:
            cell.descriptionLabel.text = alarmModels[indexPath.row].description
        case Set(Days.allCases):
            cell.descriptionLabel.text = "\(alarmModels[indexPath.row].description)，每天"
        default:
            cell.descriptionLabel.text = " \(alarmModels[indexPath.row].description)， \(alarmModels[indexPath.row].repeatState!)"
        }
    }
    
    @objc func setStateSwitch(sender: UISwitch)
    {
        let indexPath = sender.tag
        alarmModels[indexPath].isOnState = sender.isOn
        print("Switch indexPath:\(indexPath)")
    }
    
    @IBAction func editBtn(_ sender: UIBarButtonItem)
    {
        isEditing.toggle()
        alarmTableView.setEditing(isEditing, animated: true)
        sender.title = (!isEditing) ? "編輯" : "完成"
        tapBtn = "編輯"
    }
    
    
    private func setTableViewEmptyState(){
        if alarmModels.count == 0
        {
            alarmTableView.separatorStyle = .none
            showNoAlarms.isHidden = false
        }else
        {
            showNoAlarms.isHidden = true
        }
    }
    private func loadAlarmData()
    {
        if let loadData = UserDefaults.standard.object(forKey: "listAlarmModel") as? Data
        {
            let decoder = JSONDecoder()
            if let alarmData = try! decoder.decode([AlarmModel]?.self, from: loadData)
            {
                self.alarmModels = alarmData
                alarmTableView.reloadData()
            }
        }
    }
    private func saveData()
    {
        let encoder = JSONEncoder()
        if let encodeListData = try? encoder.encode(self.alarmModels)
        {
            UserDefaults.standard.set(encodeListData, forKey: "listAlarmModel")
        }
        print("儲存成功")
    }
    //MARK: - 接收DetailViewController傳遞過來的alarmModel並且reloadData
    func passingAlarmModel(alarmModel: AlarmModel)
    {
        if tapBtn == "編輯"
        {
            alarmModels[indexPath!.row] = alarmModel
            
        }else if tapBtn == "新增"
        {
            alarmModels.append(alarmModel)
            
        }
        alarmModels.sort { $0.times < $1.times }
        navigationItem.leftBarButtonItem?.title = "編輯"
        alarmTableView.isEditing = false
        alarmTableView.reloadData()
    }
    
    
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
                let detailVC = secondNVC.topViewController as! DetailViewController
                detailVC.delegate = self
            }
        }
    }
}


extension AlarmViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlarmTableViewCell
        cell.setUp(listAlarmModel: alarmModels[indexPath.row])
        setCellTextColor(cell: cell)
        cell.stateSwitch.tag = indexPath.row
        cell.stateSwitch.addTarget(self, action: #selector(self.setStateSwitch(sender:)), for: .valueChanged)
        showText(cell: cell, indexPath: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20 )
        tableView.tableFooterView = UIView()
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

extension AlarmViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        self.view = nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        setEditing(false, animated: true)
        tableView.isEditing.toggle()
        navigationItem.leftBarButtonItem?.title = (!isEditing) ? "編輯" : "完成"
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print(#function)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, complete) in
            self.alarmModels.remove(at: indexPath.row)
            self.alarmTableView.deleteRows(at: [indexPath], with: .none)
            complete(true)
        }
        
        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipConfiguration
    }
    
}
