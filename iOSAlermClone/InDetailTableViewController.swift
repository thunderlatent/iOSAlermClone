//
//  InDetailTableViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/12.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class InDetailTableViewController: UITableViewController {
    @IBOutlet weak var laterMinderSwitch: UISwitch!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ringLabel: UILabel!
    var repeatTableViewController: RepeatTableViewController?
    var labelViewController: LabelViewController?
    var indexPath: Int?
    var select: [Int:String] = [:]
//    var tempDescriptionLabel = "鬧鐘Temp"
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("tempDescriptionLabel = \(tempDescriptionLabel)")
        
        
        }
    override func viewDidAppear(_ animated: Bool) {
        displayRepeatState()
        if let text = labelViewController?.descriptionTF.text
        {
            print("Line 28 descriptionLabel.text:\(text)")
            descriptionLabel.text = text
//            self.tempDescriptionLabel = descriptionLabel.text!

        }
    }
   
    func displayRepeatState()
    {
        if let select = repeatTableViewController?.selectDaysOfWeek
        {
            self.select = select
            if select.count == 0
            {
                repeatLabel.text = "永不"
            }else if select.count == 1
            {
                repeatLabel.text = "星期\(select.first!.value)"
            }else if select.count > 1 && select.count < 7
            {
                if select.count == 2, select[0] == "日", select[6] == "六"
                {
                    repeatLabel.text = "週末"
                }else
                {
                    let keys = select.keys.sorted(by: <)
                    var repeatText = ""
                    for key in keys
                    {
                        repeatText += "週" + "\(select[key]!) "
                    }
                    repeatLabel.text = repeatText
                }
            }else if select.count == 7
            {
                repeatLabel.text = "每天"
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryView?.backgroundColor = .yellow
        cell.editingAccessoryView?.tintColor = .blue
        cell.editingAccessoryView?.backgroundColor = .red
        cell.backgroundView?.backgroundColor = .green
        let checkMark = UIImageView(image: UIImage(systemName: "chevron.right"))
        cell.accessoryView = checkMark
        let selectBackGroundView: UIView = {
            let selectView = UIView()
            selectView.backgroundColor = UIColor(red: 60, green: 60, blue: 60)
            return selectView
        }()
        cell.selectedBackgroundView = selectBackGroundView
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepeatTBC"
        {
            if let repeatTBC = segue.destination as? RepeatTableViewController
            {
                repeatTableViewController = repeatTBC
                repeatTBC.selectDaysOfWeek = select
                print("Select:\(select)")
            }
        }else if segue.identifier == "showLabelVC"
        {
            if let labelVC = segue.destination as? LabelViewController
            {
                labelViewController = labelVC
                labelVC.textTF = descriptionLabel.text!
            }
        }
    }
    

}
