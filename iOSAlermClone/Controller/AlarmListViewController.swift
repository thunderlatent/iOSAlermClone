//
//  ViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/10.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController,PassingAlarmModelDelegate {
    //MARK:- Properties
    private var alarmModels = [AlarmModel]()
    {
        didSet
        {
            self.setTableViewEmptyState()
            self.saveAlarmDatasIntoUserDefault()
        }
    }
    private var indexPathOfAlarmModels: IndexPath?
    private var editMode: EditMode = .modify
    
    
    //MARK:- UI Element
    @IBOutlet weak var alarmListTableView: UITableView!
    private var indicatingNoAlarmLabel:UILabel =
        {

            let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 4,
                                              y: UIScreen.main.bounds.height / 4,
                                              width: UIScreen.main.bounds.width / 2,
                                              height: UIScreen.main.bounds.height / 10))
            label.text = "無鬧鐘資料"
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont(descriptor: UIFontDescriptor(name: "system", size: 30), size: 30)
            label.backgroundColor = .black
            return label
        }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmListTableView.delegate = self
        alarmListTableView.dataSource = self
        alarmListTableView.addSubview(indicatingNoAlarmLabel)
        loadAlarmDatasFromUserDefault()
        setTableViewEmptyState()
        
        //MARK: - 讓列表底部不要有分隔線
        alarmListTableView.tableFooterView = UIView()

    }
    
    //MARK:- override Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondNVC = segue.destination as! UINavigationController
        if editMode == .modify
        {
            if segue.identifier == "showDetail"
            {
                let detailVC = secondNVC.topViewController as! DetailViewController
                if let indexPath = indexPathOfAlarmModels, alarmModels.count > 0
                {
                    detailVC.alarmModel = alarmModels[indexPath.row]
                    detailVC.passingAlarmModelDelegate = self
                }
            }
        }else if editMode == .append
        {
            if segue.identifier == "showDetail"
            {
                let detailVC = secondNVC.topViewController as! DetailViewController
                detailVC.passingAlarmModelDelegate = self
            }
        }
    }
    
    //MARK:- 當switch狀態改變時同時改變cell文字顏色
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
    

    //MARK: - cell內的Switch被觸發時呼叫此方法
    @objc func cellSwitchValueChange(sender: UISwitch)
    {
        let indexPath = sender.tag
        alarmModels[indexPath].isOnState = sender.isOn
    }
    
    
    
    //MARK: - AlarmListTableView沒有任何鬧鐘時的狀態
    private func setTableViewEmptyState(){
        if alarmModels.count == 0
        {
            alarmListTableView.separatorStyle = .none
            indicatingNoAlarmLabel.isHidden = false
        }else
        {
            indicatingNoAlarmLabel.isHidden = true
        }
    }
    private func loadAlarmDatasFromUserDefault()
    {
        if let loadData = UserDefaults.standard.object(forKey: "listAlarmModel") as? Data
        {
            let decoder = JSONDecoder()
            if let alarmData = try! decoder.decode([AlarmModel]?.self, from: loadData)
            {
                self.alarmModels = alarmData
                alarmListTableView.reloadData()
            }
        }
    }
    private func saveAlarmDatasIntoUserDefault()
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
        if editMode == .modify
        {
            alarmModels[indexPathOfAlarmModels!.row] = alarmModel
            
        }else if editMode == .append
        {
            alarmModels.append(alarmModel)
            
        }
        alarmModels.sort { $0.times < $1.times }
        navigationItem.leftBarButtonItem?.title = EditMode.modify.string
        alarmListTableView.isEditing = false
        alarmListTableView.reloadData()
    }
    
    
    
    //MARK: -  IBAction
    //MARK: - 左上角的編輯按鈕
    @IBAction func editBtn(_ sender: UIBarButtonItem)
    {
        isEditing.toggle()
        alarmListTableView.setEditing(isEditing, animated: true)
        sender.title = (!isEditing) ? EditMode.modify.string : EditMode.complete.string
        editMode = .modify
    }
    //MARK: - 新增鬧鐘
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        editMode = .append
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
}


extension AlarmListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.alarmListCell.identifier) as! AlarmTableViewCell
        cell.configure(alarmModel: alarmModels[indexPath.row], row: indexPath.row)
        
        //MARK: - 在這addTarget的用意是因為這個方法會改變到model的值，我不想要在view（cell內）做這件事情，如果要在cell的類別內做，就不能直接改值，要從cell發一個delegate過來controller，讓controller改model的值
        cell.stateSwitch.addTarget(self, action: #selector(self.cellSwitchValueChange(sender:)), for: .valueChanged)
                return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}


extension AlarmListViewController: UITableViewDelegate
{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPathOfAlarmModels = indexPath
        setEditing(false, animated: true)
        tableView.isEditing.toggle()
        navigationItem.leftBarButtonItem?.title = (!isEditing) ? EditMode.modify.string : "完成"
        performSegue(withIdentifier: Identifier.Segue.showDetail.identifier, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, complete) in
            self.alarmModels.remove(at: indexPath.row)
            self.alarmListTableView.deleteRows(at: [indexPath], with: .none)
            complete(true)
        }
        
        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipConfiguration
    }
    
}


extension AlarmListViewController
{
    enum EditMode: String
    {
        case modify
        case append
        case complete
        var string: String
        {
            switch self
            {
            case .modify:
                return "編輯"
            case .append:
                return "新增"
            case .complete:
                return "完成"
            }
        }
    }
}
