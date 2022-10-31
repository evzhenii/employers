//
//  PhoneButton.swift
//  employers
//
//  Created by boockich mac on 31.10.2022.
//

import UIKit

final class PhoneButton: UIButton {

    var phone : String = ""

    convenience init(phone: String) {
        self.init()
        self.phone = phone
    }
}
