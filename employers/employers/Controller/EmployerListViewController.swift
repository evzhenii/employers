//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class EmployerListViewController: UITableViewController {
    
    var employersManager = EmployersManager()
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
//        employersManager.load()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
                
        cell.textLabel?.text = "\(indexPath.row)"
        
        if let companyJSON = cachedDataSource.object(forKey: indexPath.row as AnyObject) {
            let name = companyJSON.company.employees[indexPath.row].name
            cell.textLabel?.text = name
        } else {
            
            employersManager.load { (companyJSON) in
                guard let companyJSON = companyJSON else { return }
                self.cachedDataSource.setObject(companyJSON, forKey: indexPath.row as AnyObject)
                let name = companyJSON.company.employees[indexPath.row].name
                DispatchQueue.main.async {
                    cell.textLabel?.text = name
                    tableView.reloadData()
                }
            }
            
            
            
//            let companyJSON = employersManager.load()
//            cachedDataSource.setObject(companyJSON, forKey: indexPath.row as AnyObject)
//            let name = companyJSON.company.employees[indexPath.row].name
//            cell?.textLabel?.text = name
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

extension EmployerListViewController: EmployersManagerDelegate {
    
    func didFailWithError(_ error: Error) {
        print("oh no")
    }
}

//extension EmployerListViewController: UITableViewDelegate {
//
//}
//
//extension EmployerListViewController: UITableViewDataSource {
//
//}
