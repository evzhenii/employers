//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

final class EmployersTableViewController: UITableViewController {
    
    let cachedDataSource = NSCache<AnyObject, CompanyJSON>()
    var employersManager = EmployersManager()
    let networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employersManager.delegate = self
        
        self.title = cachedDataSource.object(forKey: Constants.companyJSONKey as AnyObject)?.company.name
        
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: Constants.employeeTableViewCellIdentifier)
        
        employersManager.monitorNetwork()
        
        refreshControlSetup()
    }
    
    private func refreshControlSetup() {
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.employeeTableViewCellIdentifier, for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        
        if let companyJSON = cachedDataSource.object(forKey: Constants.companyJSONKey as AnyObject) {
            
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        
        guard let employeesCount = cachedDataSource
            .object(forKey: Constants.companyJSONKey as AnyObject)?
            .company
            .employees
            .count else { return 1 }
            return employeesCount
    }
    
    @objc func refresh(_ sender: AnyObject) {
        networkingManager.load { companyJSON in
            guard let companyJSON else { return }
            self.cachedDataSource.setObject(companyJSON, forKey: Constants.companyJSONKey as AnyObject)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}

//MARK: - EmployersManager
extension EmployersTableViewController: EmployersManagerDelegate {
    
    func lostConnection() {
        DispatchQueue.main.async {
            let alert = NotificationAlertController(title: Constants.genericErrorMessage, message: Constants.Errors.lostConnection, preferredStyle: .alert)
            self.present(alert, animated: true)
            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)

            let noInternetImage = UIImage(systemName: Constants.noInternetSystemImage, withConfiguration: configuration)
            let refreshBarButtonItem = UIBarButtonItem(customView: UIImageView(image: noInternetImage))
            self.navigationItem.rightBarButtonItem = refreshBarButtonItem
            self.navigationItem.rightBarButtonItem?.isHidden = false
        }
    }
    
    func restoredConnection() {
        DispatchQueue.main.async {
        self.navigationItem.rightBarButtonItem?.isHidden = true
        }
    }
}
