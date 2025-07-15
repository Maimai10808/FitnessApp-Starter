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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkoutSegue" {
            let destinationVC     = segue.destination as! WorkoutViewController
            let selectedProgram   = sender            as! Program
            destinationVC.program = selectedProgram
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName   = "ProgramTableViewCell"
        
        
        tableView.dataSource     = self
        tableView.delegate       = self
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProgram = programs[indexPath.row]
        performSegue(withIdentifier: "WorkoutSegue", sender: selectedProgram)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

/*
 
 [DashboardViewController]
          ↓
 点击 cell (didSelectRowAt)
          ↓
 performSegue("workoutSegue", sender: selectedProgram)
          ↓
 prepare(for: segue, sender:)
          ↓
 destinationVC.program = sender as? Program
          ↓
 [WorkoutViewController]
         ↓
 使用 program 进行 UI 展示 / workout 逻辑执行
 
 在 iOS 开发中，sender 的中文意思是：

 发送者，即触发这个操作的“源对象”或“传递的数据”。 触发事件的对象 / 传递的数据

 
 @IBAction func buttonTapped(_ sender: UIButton) {
     // sender 就是触发这个方法的按钮本身
 }
 */

