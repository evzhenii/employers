//
//  EmployersManager.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit

struct EmployersManager {
    
    func makeCall(with phoneNumber: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "tel"
        urlComponents.path = phoneNumber
        
        guard let url = urlComponents.url,
              UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
