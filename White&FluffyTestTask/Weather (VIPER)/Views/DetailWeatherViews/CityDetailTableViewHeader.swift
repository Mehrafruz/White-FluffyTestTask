//
//  CityDetailTableViewHeader.swift
//  White&FluffyTestTask
//
//  Created by Мехрафруз on 08.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct CityDetailTableViewHeaderModel {
    let title: String?
    let condition: String?
    let temperature: String?
    let icon: String?
}

class CityDetailTableViewHeader: UITableViewHeaderFooterView {
    
    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let conditionLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func setup() {
        titleLabel.font = UIFont.systemFont(ofSize: 38, weight: .semibold)
        titleLabel.textAlignment = .center
        temperatureLabel.font = UIFont.systemFont(ofSize: 58, weight: .medium)
        conditionLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        conditionLabel.textColor = .darkGray
        iconImageView.contentMode = .scaleAspectFill
        
        [iconImageView, titleLabel, conditionLabel, temperatureLabel].forEach {
            contentView.addSubview($0) }
        addConstraint()
    }
    
    func addConstraint () {
        [contentView, iconImageView, titleLabel, conditionLabel, temperatureLabel].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 180),
            iconImageView.heightAnchor.constraint(equalToConstant: 180),
            iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            conditionLabel.heightAnchor.constraint(equalToConstant: 30),
            conditionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 50),
            conditionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60),
            temperatureLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 50),
            temperatureLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(with model: CityDetailTableViewHeaderModel) {
        iconImageView.image = UIImage(named: model.icon ?? "")
        titleLabel.text = model.title
        conditionLabel.text = model.condition
        temperatureLabel.text = "\(model.temperature ?? "")°C"
    }
    
    
}
