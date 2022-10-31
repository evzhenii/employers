//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class EmployersTableViewController: UITableViewController {
    
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    let employersManager = EmployersManager()
    var networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cachedDataSource.object(forKey: Constants.companyJSONKey as AnyObject)?.company.name
        
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: Constants.employeeTableViewCellIdentifier)
        
        networkingManager.monitorNetwork()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.employeeTableViewCellIdentifier, for: indexPath) as? EmployeeTableViewCell else {
            print ("cannot convert cell")
            return UITableViewCell()
        }
        
        if let companyJSON = cachedDataSource.object(forKey: Constants.companyJSONKey as AnyObject) {
            
            cell.isUserInteractionEnabled = false
            let name = companyJSON.company.employees[indexPath.row].name
            cell.nameLabel.text = name
            
            let number = companyJSON.company.employees[indexPath.row].phone_number
            cell.phoneButton.setTitle(number, for: .normal)
            cell.phoneButton.phone = number
            cell.phoneButton.addTarget(self, action: #selector(phoneButtonPressed), for: .touchUpInside)
            
            let skills = companyJSON.company.employees[indexPath.row].skills
            let joinedSkills = skills.joined(separator: ", ")
            cell.skillsLabel.text = joinedSkills
        }
        
        return cell
    }
    
    @objc func phoneButtonPressed(_ sender: Any) {
        guard let phoneNumber = (sender as? PhoneButton)?.phone else {
            print("cannot get phone number")
            return
        }
        
        employersManager.makeCall(with: phoneNumber)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let employeesCount = cachedDataSource.object(forKey: Constants.companyJSONKey as AnyObject)?.company.employees.count {
            return employeesCount
        } else {
            return 1
        }
    }
    
}

extension EmployersManager: ErrorHandlerDelegate {
    func presentError(_ error: String) {
        print(error)
    }
}
