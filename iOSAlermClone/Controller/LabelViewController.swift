//
//  LabelViewController.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/17.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var descriptionTF: UITextField!
    var textTF = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTF.delegate = self
        if textTF.isEmpty || textTF == ""
        {
            textTF = "鬧鐘"
        }
        descriptionTF.text = textTF
      
    }
    override func viewWillAppear(_ animated: Bool) {
        descriptionTF.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        if descriptionTF.text!.isEmpty || descriptionTF.text == ""
        {
            descriptionTF.text = "鬧鐘"
            textTF = "鬧鐘"
        }else
        {
            textTF = descriptionTF.text!
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if descriptionTF.text!.isEmpty || descriptionTF.text == ""{
            descriptionTF.text = "鬧鐘"
            textTF = "鬧鐘"
        }
        navigationController?.popViewController(animated: true)
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    deinit {
        print("TF:\(descriptionTF.text)")
    }
}
