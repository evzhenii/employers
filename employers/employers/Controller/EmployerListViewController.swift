//
//  ViewController.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class EmployerListViewController: UIViewController {

    var employersManager = EmployersManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        employersManager.load()
        // Do any additional setup after loading the view.
    }


}

extension EmployerListViewController: EmployersManagerDelegate {
    func didFailWithError(_ error: Error) {
        print("oh no")
    }
    
    
}
