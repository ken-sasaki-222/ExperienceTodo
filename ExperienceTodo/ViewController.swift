//
//  ViewController.swift
//  ExperienceTodo
//
//  Created by sasaki.ken on 2021/09/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var todoList = [String]()
    private var userDefaults = UserDefaults.standard
    private var userDefaultskey = "todoList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTodoList()
        setNavigation()
        setTableView()
    }
    
    private func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemTeal
        appearance.titleTextAttributes =  [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func refreshTodoList() {
        guard let todoList = userDefaults.object(forKey: userDefaultskey) as? [String] else {
            return
        }
        self.todoList = todoList
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "やることを追加", message: "やることを入力してください", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "追加", style: .default) { _ in
            guard let newTodo = alert.textFields?.first?.text else {
                return
            }
            self.todoList.insert(newTodo, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
            self.userDefaults.set(self.todoList, forKey: self.userDefaultskey)
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            userDefaults.set(self.todoList, forKey: self.userDefaultskey)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todoText = cell.viewWithTag(1) as? UILabel
        todoText?.text = todoList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
