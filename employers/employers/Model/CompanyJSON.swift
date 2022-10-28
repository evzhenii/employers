//
//  CompanyEmployers.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import Foundation

final class CompanyJSON: NSObject, Codable {
    let company: Company
}

struct Company: Codable {
    let name: String
    let employees: [Employee]
}

struct Employee: Codable {
    let name: String
    let phone_number: String
    let skills: [String]
}

