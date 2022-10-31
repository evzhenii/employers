//
//  EmployersManager.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit
import Network

struct EmployersManager {
    
    var delegate: EmployersManagerDelegate?
    
    func makeCall(with phoneNumber: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.urlComponentsScheme
        urlComponents.path = phoneNumber
        
        guard let url = urlComponents.url,
              UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                delegate?.lostConnection()
            } else {
                delegate?.restoredConnection()
            }
        }
        
        let queue = DispatchQueue(label: Constants.nwPathMonitorQueue)
        monitor.start(queue: queue)
    }
}
