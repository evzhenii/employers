//
//  SpinnerViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    let spinnerView = SpinnerView()
    var employersManager = EmployersManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        employersManager.delegate = self
        
        view.addSubview(spinnerView)
        spinnerView.center = view.center
        
        
        employersManager.load { [weak self] (companyJSON) in
            guard let companyJSON = companyJSON else { return }
            
            DispatchQueue.main.async {
                
                let employerTableViewController = EmployerTableViewController()
                
                employerTableViewController.modalPresentationStyle = .fullScreen
                
                employerTableViewController.cachedDataSource.setObject(companyJSON, forKey: "Avito" as AnyObject)
                
                self?.spinnerView.spinner.stopAnimating()
                self?.present(employerTableViewController, animated: true)
            }
        }
    }
}




//MARK: - EmployersManagerDelegate
extension SpinnerViewController: EmployersManagerDelegate {
    
    func didFailWithError(_ error: Error) {
        print("oh no")
    }
}

