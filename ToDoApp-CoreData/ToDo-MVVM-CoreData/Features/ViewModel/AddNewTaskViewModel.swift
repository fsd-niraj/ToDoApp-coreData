
//  Created by Niraj Panchal on 11.08.2023 on 29.04.2022.
//

import Foundation
import UIKit

class AddNewTaskViewModel {
    var name: String
    var dueDate: Date
    var isUrgent: Bool
    
    init(name: String, dueDate: Date, isUrgent: Bool) {
        self.name = name
        self.dueDate = dueDate
        self.isUrgent = isUrgent
    }
    
    func saveTask(completion: @escaping (Bool) -> Void) {
        CoreDataManager.shared.saveToDo(name: self.name, dueOn: self.dueDate, isUrgent: self.isUrgent, completion: completion)
    }
}
