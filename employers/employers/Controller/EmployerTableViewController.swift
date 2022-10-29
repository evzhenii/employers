//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit



class EmployerTableViewController: UITableViewController {
    
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cachedDataSource.object(forKey: "Avito" as AnyObject)?.company.name
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if let companyJSON = cachedDataSource.object(forKey: "Avito" as AnyObject) {
            let name = companyJSON.company.employees[indexPath.row].name
            cell.textLabel?.text = name
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
}
