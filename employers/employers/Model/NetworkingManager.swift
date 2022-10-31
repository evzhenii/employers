//
//  EmployersManager.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import Foundation

protocol EmployersManagerDelegate {
    
    func didFailWithError(_ error: Error)
}

struct NetworkingManager {
    
    let stringUrl = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    var delegate: EmployersManagerDelegate?
    
    func load(completion: @escaping ((CompanyJSON?) -> Void)) {
        guard let url = URL(string: stringUrl) else {
            print("Cannot convert string URL to URL")
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                self.delegate?.didFailWithError(error!)
                return
            }
            
            guard let safeData = data else {
                print("no data")
                return
            }
            if let companyJSON = parseJSON(safeData) {
                companyJSON.company.employees = companyJSON.company.employees.sorted()
                completion(companyJSON)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> CompanyJSON? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CompanyJSON.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
