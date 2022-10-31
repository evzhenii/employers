//
//  EmployersManager.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import Foundation
import Network

struct NetworkingManager {
    
    var delegate: ErrorHandlerDelegate?
    
    func load(completion: @escaping ((CompanyJSON?) -> Void)) {
        guard let url = URL(string: Constants.url) else {
            delegate?.presentError(Constants.Errors.cannotConvertURL)
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                delegate?.presentError(error.localizedDescription)
                return
            }
            
            guard let safeData = data else {
                delegate?.presentError(Constants.Errors.missingData)
                return
            }
            if let companyJSON = parseJSON(safeData) {
                companyJSON.company.employees = companyJSON.company.employees.sorted()
                completion(companyJSON)
            }
        }
        task.resume()
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                delegate?.presentError(Constants.Errors.lostConnection)
            }
        }
        
        let queue = DispatchQueue(label: Constants.nwPathMonitorQueue)
        monitor.start(queue: queue)
    }
    
    private func parseJSON(_ data: Data) -> CompanyJSON? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CompanyJSON.self, from: data)
            return decodedData
        } catch {
            delegate?.presentError(error.localizedDescription)
            return nil
        }
    }
}
