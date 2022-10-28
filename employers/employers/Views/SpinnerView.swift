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
        setupViews()
        setupLayout()
    }
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
//        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.style = .large
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private func setupViews() {
        addSubview(spinner)
    }
    
    private func setupLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
