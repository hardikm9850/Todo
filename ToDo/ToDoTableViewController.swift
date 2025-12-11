//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Hardik Mehta on 08/12/25.
// Create a storyboard
// 

import UIKit
import SwiftData

/*
 UITableViewController is a specialized view controller that:

 already contains a UITableView
 automatically acts as its delegate + dataSource
 */
class ToDoTableViewController: UITableViewController {

    /*
     A UITableView is iOS’s equivalent of Android’s RecyclerView.
     It shows a vertical list of rows and reuses a small number of cells to keep memory low.
     It’s like using an Activity that already has a RecyclerView built-in
     */
    @IBOutlet weak var todoTableView: UITableView!
    var context: ModelContext!
    var items: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
        self.title = "To-Do List"
        
        navigationItem.title = "To-Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
    }
    
    func fetchTodos() {
        do {
            let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.date)])
            items = try context.fetch(descriptor)
            tableView.reloadData()
        } catch {
            print("Error fetching: \(error)")
        }
    }


    @objc func addTodo() {
        let addVC = AddTodoViewController()
        addVC.onSave = { [weak self] title, date in
            guard let self = self else { return }
            let todo = Todo(title: title, date: date)
            self.context.insert(todo)
            self.fetchTodos()
        }
        let nav = UINavigationController(rootViewController: addVC)
        present(nav, animated: true)
    }
    
}

extension ToDoTableViewController {
    // How many sections?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // How many rows in each section?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // Gimme a cell for this row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "todoCell")
        let todo = items[indexPath.row]

        cell.textLabel?.text = todo.title

        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from: todo.date)

        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let todo = items[indexPath.row]
                    context.delete(todo)
                    items.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

