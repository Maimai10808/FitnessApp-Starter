//
//  ViewController.swift
//  FitnessApp
//
//

import UIKit

class DashboardViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let programs: [Program] = [
        Program.beginnerMockProgram,
        Program.intermediateMockProgram,
        Program.advancedMockProgram
    ]
    
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
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.identifer,
                                                 for: indexPath) as! ProgramTableViewCell
        
        let program = programs[indexPath.row]
        
        cell.configure(withProgram: program)
        
        return cell
    }
}

// MARK: TableView Delegate
extension DashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

