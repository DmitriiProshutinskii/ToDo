//
//  ViewController.swift
//  Tasks
//
//  Created by Dmitrii Proshutinskii on 09.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //Таблица, в которую пишем. Прикрепляем её через storyboard
    @IBOutlet var tableView : UITableView!
    //Список задач. В последствии заменить на класс
    var tasks = [Task]()
    
    //Функция, вызывающаяся при нажатии кнопки Add. Прикрепляем её через storyboard
    @IBAction func didTapAdd() {
        //Так мы ищем по id нужный storyboard, грузим его
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                //При загрузке storyboard мы обновляем в отдельном треде задачи
                self.updateTasks()
            }   
        }
        //А теперь открываем этот storyboard с анимацией
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTasks() {
        //Удаляем все элементы списка. Не лучшее решение, но пока так
        //MARK - Fix It
        tasks.removeAll()
        
        if let tasks_ = UserDefaults().value(forKey: "tasks") as? [Task] {
            tasks = tasks_
        }
        else {
            return
        }
        tableView.reloadData()
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup. Если ещё ничего нет в UseDefault, то инициируем стандартными значениями
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set([], forKey: "tasks")
        }

        self.updateTasks()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "Task"
        vc.update = {
            DispatchQueue.main.async {
                //При загрузке storyboard мы обновляем в отдельном треде задачи
                self.updateTasks()
            }
        }
        vc.taskId = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].label
        return cell
    }
}
