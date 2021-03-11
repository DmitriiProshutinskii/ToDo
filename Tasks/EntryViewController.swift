//
//  EntryViewController.swift
//  Tasks
//
//  Created by Dmitrii Proshutinskii on 09.03.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    @IBOutlet var text_: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Почему?
        field.delegate = self
        // Do any additional setup after loading the view.
        
        //Как сделать кнопку навигационного меню программно
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShoudReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
        
    }
    
    @objc func saveTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        guard var tasks_ = UserDefaults().value(forKey: "tasks") as? [Task] else { return }
        
        
        tasks_.append(Task(label: field.text ?? "Label", text: text_.text ?? "Text here" ))
        UserDefaults().set(tasks_, forKey: "tasks")
        
        update?()
        print("We are here")
        navigationController?.popViewController(animated: true)
    }

}
