//
//  ViewController.swift
//  ExperienceTodo
//
//  Created by sasaki.ken on 2021/09/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigation()
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
    
    @IBAction func tapAddButton(_ sender: Any) {
        print("追加")
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todoText = cell.viewWithTag(1) as? UILabel
        todoText?.text = "散歩行く"
        
        return cell
    }
}

