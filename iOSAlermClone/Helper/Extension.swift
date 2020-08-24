//
//  Extension.swift
//  iOSAlermClone
//
//  Created by Jimmy on 2020/8/24.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
extension UITextField {
    func modifyClearButton(){
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "clear"), for: .normal)
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
}
}

extension UIColor
{
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat)
    {
        let red = red / 255
        let green = green / 255
        let blue = blue / 255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
