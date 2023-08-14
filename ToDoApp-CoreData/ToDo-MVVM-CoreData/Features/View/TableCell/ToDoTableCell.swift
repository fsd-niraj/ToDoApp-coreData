
//  Created by Niraj Panchal on 11.08.2023
//

import UIKit

class ToDoTableCell: UITableViewCell {
    
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var taskDueDate: UILabel!
    @IBOutlet private weak var taskCompletedDate: UILabel!
    @IBAction func isUrgent(_ sender: UISwitch) {
    }
    
    var todo: ToDo? {
        didSet {
            if let todo = todo {
                if todo.completedTask == false {
                    taskNameLabel.text = todo.name
                    taskDueDate.text = String(format: "Due On: %@", todo.dueOn!.toString(format: "MMM dd, yy"))
                    taskCompletedDate.text = "Not completed"
                }else {
                    taskNameLabel.attributedText = todo.name?.strikeThrough()
                    taskDueDate.attributedText = String(format: "Due On: %@", todo.dueOn!.toString(format: "MMM dd, yy")).strikeThrough()
                    taskCompletedDate.text = String(format: "Completed On: %@", todo.completedOn!.toString(format: "MMM dd, yy"))
                }
            }
        }
    }
    override func prepareForReuse() {
        taskNameLabel.attributedText = taskNameLabel.text?.removeAttributedText()
        taskNameLabel.text = ""
        taskDueDate.attributedText = taskDueDate.text?.removeAttributedText()
        taskDueDate.text = ""
        taskCompletedDate.text = ""
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
