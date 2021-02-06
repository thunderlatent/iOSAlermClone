
import UIKit
//MARK: - 用來表示星期幾的Enum，這樣寫可以表示Int以及String
//MARK: - 用法：Days.sunday.rawValue // 0,  Days.sunday.dayString // 日
enum Days: Int, CaseIterable,Codable
{
    case sunday = 0,monday,tuesday,wednesday,thursday,friday,saturday
    var dayString: String
    {
        switch self {
        case .sunday:
            return "日"
        case .monday:
            return "一"
        case .tuesday:
            return "二"
        case .wednesday:
            return "三"
        case .thursday:
            return "四"
        case .friday:
            return "五"
        case .saturday:
            return "六"
        }
    }
}

