//
//  ViewController.swift
//  FitnessApp
//
//

import UIKit

class DashboardViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName   = "ProgramTableViewCell"
        
        tableView.dataSource = self
        tableView.delegate   = self
        
        tableView.register(UINib(nibName: nibName, bundle: nil),
                           forCellReuseIdentifier: ProgramTableViewCell.identifer)
        tableView.separatorStyle = .none
    }


}


// MARK: TableView Datasource
extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.identifer,
                                                 for: indexPath) as! ProgramTableViewCell
        
        cell.configure(title: "Beginner", duration: 2, calories: 300, image: UIImage(named: "man-lunge")!)
        
        return cell
    }
}

// MARK: TableView Delegate
extension DashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

