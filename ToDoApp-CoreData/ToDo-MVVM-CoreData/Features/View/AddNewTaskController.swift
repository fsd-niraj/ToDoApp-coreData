
//  Created by Niraj Panchal on 11.08.2023 on 29.04.2022.
//

import UIKit

class AddNewTaskController: UITableViewController {
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDueOn: UIDatePicker!

    @IBOutlet weak var isUrgent: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDueOn.minimumDate = Date()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func saveNewTask(_ sender: UIBarButtonItem) {
        let myData = AddNewTaskViewModel(name: taskName.text ?? "No Task", dueDate: taskDueOn.date, isUrgent: isUrgent.isOn)
        if myData.name != ""{
            saveButton.isEnabled = true
            myData.saveTask { _ in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
