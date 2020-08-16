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
    var indexPath: Int?
    var repeatText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: #selector(self.barButtonAction))
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        if let select = repeatTableViewController?.selectDaysOfWeek
        {
            if select.count == 1
            {
                repeatLabel.text = "星期\(select.first!.value)"
            }else if select.count > 1
            {
                let keys = select.keys.sorted(by: <)
                for key in keys
                {
                    repeatText += "週" + "\(select[key]!) "
                }
                repeatLabel.text = repeatText
            }
            print("select:\(select)")
            
        }
    }
    @objc func barButtonAction()
       {
           self.navigationController?.popToRootViewController(animated: true)
           print("Button pressed")
           
       }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//          if let vc = mainStoryboard.instantiateViewController(withIdentifier: "repeat") as? RepeatTableViewController
//          {
//              present(vc, animated: false, completion: nil)
//          }
        print("indexPath.row = \(indexPath.row)")
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepeatTBC"
        {
            if let repeatTBC = segue.destination as? RepeatTableViewController
            {
                repeatTableViewController = repeatTBC
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
