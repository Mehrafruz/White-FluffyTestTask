//
//  CityWeatherTableViewCell.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct CityTableViewCellModel {
    let title: String
    let condition: String?
    let temperature: Int?
    let icon: String?
}

class CityWeatherTableViewCell: UITableViewCell {
    
    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let conditionLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        temperatureLabel.font = UIFont.systemFont(ofSize: 38, weight: .medium)
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
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            conditionLabel.heightAnchor.constraint(equalToConstant: 30),
            conditionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 30),
            conditionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            temperatureLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 30),
            temperatureLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func configure(with model: CityTableViewCellModel) {
        iconImageView.image = UIImage(named: model.icon ?? "")
        titleLabel.text = model.title
        conditionLabel.text = model.condition
        if let temperature = model.temperature {
            temperatureLabel.text = "\(temperature)˚C"
        } else {
            temperatureLabel.text = nil
        }
    }
    
}
