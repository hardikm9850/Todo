//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by Hardik Mehta on 08/12/25.
//

import UIKit

class AddTodoViewController: UIViewController {
    
    var onSave: ((String, Date) -> Void)? // Closure to pass data back
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter todo description"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add Todo"
        setupTextField()
        setupSaveButton()
    }
    
    func setupTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTodo))
    }
    
    @objc func saveTodo() {
        guard let text = textField.text, !text.isEmpty else { return }
        let now = Date()
        onSave?(text,now) // Pass data back
        dismiss(animated: true)
    }
}
