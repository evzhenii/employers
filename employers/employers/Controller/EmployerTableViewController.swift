//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class EmployerTableViewController: UITableViewController {
    
    var employersManager = EmployersManager()
    var companyName: String?
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        employersManager.load { [weak self] (companyJSON) in
            guard let companyJSON = companyJSON else { return }
            self?.companyName = companyJSON.company.name
            self?.cachedDataSource.setObject(companyJSON, forKey: self?.companyName as AnyObject)
            DispatchQueue.main.async {
                    self?.title = companyJSON.company.name
                    self?.tableView.reloadData()
                }
            }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if let companyJSON = cachedDataSource.object(forKey: companyName as AnyObject) {
            let name = companyJSON.company.employees[indexPath.row].name
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
}


