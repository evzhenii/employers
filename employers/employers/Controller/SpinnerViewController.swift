//
//  SpinnerViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    let spinnerView = SpinnerView()
    var networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        
        networkingManager.delegate = self
        
        view.addSubview(spinnerView)
        spinnerView.center = view.center
        
        networkingManager.load { [weak self] (companyJSON) in
            guard let companyJSON = companyJSON else { return }
            
            DispatchQueue.main.async {
                
                let employerTableViewController = EmployersTableViewController()
                
                employerTableViewController.cachedDataSource.setObject(companyJSON, forKey: Constants.companyJSONKey as AnyObject)
                
                let companyNavigationController = CompanyNavigationController(rootViewController: employerTableViewController)
                
                self?.spinnerView.spinner.stopAnimating()
                self?.present(companyNavigationController, animated: true)
            }
        }
    }
}




//MARK: - EmployersManagerDelegate
extension SpinnerViewController: ErrorHandlerDelegate {
    func presentError(_ error: String) {
        print(error)
    }
    
}

