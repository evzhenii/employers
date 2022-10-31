//
//  CompanyNavigationController.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit

class CompanyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .fullScreen
        navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}