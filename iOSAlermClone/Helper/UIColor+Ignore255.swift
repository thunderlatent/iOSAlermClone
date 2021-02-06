import UIKit
//MARK: - 使用extension來達到不用每次都要輸入「RGB/255」以及alpha值
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
