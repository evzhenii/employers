//
//  CompanyNavigationController.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit

final class CompanyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .fullScreen
        navigationBar.prefersLargeTitles = true
    }
}
