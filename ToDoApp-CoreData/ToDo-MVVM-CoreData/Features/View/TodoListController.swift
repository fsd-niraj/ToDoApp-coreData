
//  Created by Niraj Panchal on 11.08.2023
//

import UIKit

class TodoListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let vm = TodoListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.refreshData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

}

extension TodoListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoTableCell
        
        cell.todo = vm.todoAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
            let todo = self.vm.todoAtIndex(indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
            if todo.completedTask == false {
                let alertController = UIAlertController(title: "Completed?", message: "Mark this task as completed?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                    self.vm.completeTaskAtIndex(indexPath.row) { (_) in
                    }
                    tableView.reloadData()
                    self.vm.refreshData()
                }))
                alertController.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                self.present(alertController, animated: true)
            }
            completion(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (_, _, completion) in
            self.vm.deleteTask(indexPath.row) { (_) in
                tableView.deleteRows(at: [indexPath], with: .top)
            }
            completion(true)
        }
        
        editAction.backgroundColor = .systemGreen
        editAction.image = UIImage(systemName: "checkmark")
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
}
