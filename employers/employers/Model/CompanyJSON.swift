//
//  CompanyEmployers.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import Foundation

final class CompanyJSON: NSObject, Codable {
    var company: Company
}

struct Company: Codable {
    let name: String
    var employees: [Employee]
}

struct Employee: Codable, Comparable {
    let name: String
    let phone_number: String
    let skills: [String]
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
            lhs.name < rhs.name
        }
}

