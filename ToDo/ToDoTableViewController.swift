//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Hardik Mehta on 08/12/25.
// Create a storyboard
// 

import UIKit
import SwiftData


class ToDoTableViewController: UITableViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var context: ModelContext!
    //var items = ["Buy Groceries", "Listen Podcast", "Study iOS", "Study DSA"]
    var items: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
        print("DEBUG: ToDoTableViewController Loaded")
        self.title = "To-Do List"
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        navigationItem.title = "To-Do List"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
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

