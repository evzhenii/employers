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
        
        navigationItem.rightBarButtonItem = noInternetBarButtonItem
//        navigationBar.navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    private let noInternetBarButtonItem: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let image = UIImage(systemName: Constants.noInternetSystemImage, withConfiguration: configuration)
        return UIBarButtonItem(customView: UIImageView(image: image))
    }()
}
