
//  Created by Niraj Panchal on 11.08.2023
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    func deleteTask(todo t: ToDo, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", t.id!.uuidString)
        
        do {
            let context = persistentContainer.viewContext
            let result = try context.fetch(request)
            if result.count > 0 {
                let todo = result.first!
                context.delete(todo)
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func completeTask(todo t: ToDo, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", t.id!.uuidString)
        
        do {
            let result = try persistentContainer.viewContext.fetch(request)
            if result.count > 0 {
                let todo = result.first!
                todo.completedTask = true
                todo.isUrgent = false
                todo.completedOn = Date()
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func getAllTodos () -> [ToDo] {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        let impTasks = NSSortDescriptor(key: "isUrgent", ascending: false)
        let incompleteDueFirst = NSSortDescriptor(key: "dueOn", ascending: true)
        let incompleteTask = NSSortDescriptor(key: "completedTask", ascending: true)
        let completeTask = NSSortDescriptor(key: "completedTask", ascending: true)
        request.sortDescriptors = [impTasks, incompleteTask, completeTask]
        var todos = [ToDo]()
        
        do {
            todos = try persistentContainer.viewContext.fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        return todos
    }
    
    func saveToDo(name: String, dueOn: Date, isUrgent: Bool, completion: @escaping (Bool) -> Void) {
        let todo = ToDo(context: persistentContainer.viewContext)
        todo.name = name
        todo.dueOn = dueOn
        todo.isUrgent = isUrgent
        todo.id = UUID()
        saveContext()
        completion(true)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo_MVVM_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
