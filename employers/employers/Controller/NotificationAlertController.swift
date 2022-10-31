//
//  NotificationAlertController.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit

final class NotificationAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAction(dismissAlertAction)
        // Do any additional setup after loading the view.
    }
    
    lazy var dismissAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
        self.dismiss(animated: true)
    }

}
