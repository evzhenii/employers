//
//  SpinnerView.swift
//  employers
//
//  Created by boockich mac on 28.10.2022.
//

import UIKit

class SpinnerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        spinner.center = center
    }
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .large
        spinner.startAnimating()
        return spinner
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
