
import UIKit
//MARK: - 這個協議是要讓DetailViewController將值傳遞回AlarmViewController
protocol PassingAlarmModelDelegate:AnyObject {
    func passingAlarmModel(alarmModel: AlarmModel)
    
}
