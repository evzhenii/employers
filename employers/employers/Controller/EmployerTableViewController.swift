//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit
import Network

class EmployerTableViewController: UITableViewController {
    
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cachedDataSource.object(forKey: "Avito" as AnyObject)?.company.name
        
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        
        monitorNetwork()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as? EmployeeTableViewCell else {
            print ("cannot convert cell")
            return UITableViewCell()
            
        }
        
        if let companyJSON = cachedDataSource.object(forKey: "Avito" as AnyObject) {
            let name = companyJSON.company.employees[indexPath.row].name
            cell.nameLabel.text = name
            
            let number = companyJSON.company.employees[indexPath.row].phone_number
            cell.numberButton.setTitle(number, for: .normal)
            
            let skills = companyJSON.company.employees[indexPath.row].skills
            let joinedSkills = skills.joined(separator: ", ")
            cell.skillsLabel.text = joinedSkills
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let employeesCount = cachedDataSource.object(forKey: "Avito" as AnyObject)?.company.employees.count {
            return employeesCount
        } else {
            return 1
        }
    }
    
    private func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                print("network unsatisfied")
            }
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
//    private func 
}
