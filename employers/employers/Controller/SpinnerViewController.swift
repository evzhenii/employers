//
//  SpinnerViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

final class SpinnerViewController: UIViewController {
    
    let spinnerView = SpinnerView()
    var networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        
        networkingManager.delegate = self
        
        view.addSubview(spinnerView)
        spinnerView.center = view.center
        
        downloadData()
    }
    
    func downloadData() {
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
        
        DispatchQueue.main.async {
            let alert = NotificationAlertController(title: Constants.genericErrorMessage, message: error, preferredStyle: .alert)
            
            alert.dismissAlertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.downloadData()
                alert.dismiss(animated: true)
            })
            
            self.present(alert, animated: true)
        }
    }
    
}

