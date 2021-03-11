//
//  TaskViewController.swift
//  Tasks
//
//  Created by Dmitrii Proshutinskii on 09.03.2021.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var text_: UITextField!
    
    var update: (() -> Void)?
    
    var taskId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = taskId {
            if let tasks = UserDefaults().value(forKey: "tasks") as? [Task]{
                label.text = tasks[id].label
                text_.text = tasks[id].text
            }
        }

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
        // Do any additional setup after loading the view.
    }
    
    
    @objc func deleteTask() {
        let vc = storyboard?.instantiateViewController(identifier: "main") as! ViewController
        
        if let id = taskId {
            if var tasks = UserDefaults().value(forKey: "tasks") as? [String]{
                tasks.remove(at: id)
                UserDefaults().setValue(tasks, forKey: "tasks")
            }
        }
        
        update?()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
