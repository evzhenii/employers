//
//  SpinnerViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class SpinnerViewController: UIViewController {

    let spinnerView = SpinnerView()
    var employerManager = EmployersManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        employerManager.delegate = self

        view.addSubview(spinnerView)
        spinnerView.center = view.center
//        spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinnerView.spinner.stopAnimating()
            let employerTableViewController = EmployerTableViewController()
            employerTableViewController.modalPresentationStyle = .fullScreen
            self.present(employerTableViewController, animated: true)
        }
    }

}

//MARK: - EmployersManagerDelegate
extension SpinnerViewController: EmployersManagerDelegate {
    
    func didFailWithError(_ error: Error) {
        print("oh no")
    }
}

