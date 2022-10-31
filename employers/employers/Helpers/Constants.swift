//
//  K.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import Foundation

struct Constants {
    
    static let url = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    static let urlComponentsScheme = "tel"
    
    static let employeeTableViewCellIdentifier = "EmployeeTableViewCell"
    
    static let companyJSONKey = "companyJSONKey"
    
    static let nwPathMonitorQueue = "Network"
    
    static let noInternetSystemImage = "wifi.slash"
    
    static let genericErrorMessage = "Whoops, I got an erorr :("
    
    struct Errors {
        static let missingData = "Wow, I couldn`t get data from server. That is strange. Already trying to fix it. Thanks for your patience, try again later"
        
        static let cannotConvertURL = "No way, URL is not avaliable at the moment. Refresh or try again later."
        
        static let lostConnection = "Well, I`ve tried to connect to the Internet, but failed. I`m smart enough to save all the necessary data, just notifying about connection."
        
    }
}
