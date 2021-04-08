//
//  CityDetailWeatherTableViewCell.swift
//  White&FluffyTestTask
//
//  Created by Мехрафруз on 08.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct CityDetailWeatherTableViewCellModel{
    let description: String
    let value: String
}

class CityDetailWeatherTableViewCell: UITableViewCell {
    private let descriptionLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup(){
        descriptionLabel.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        valueLabel.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        descriptionLabel.textColor = .darkGray
        
        [descriptionLabel, valueLabel].forEach {
            contentView.addSubview($0) }
       addConstraint()
    }
    
    private func addConstraint(){
        [contentView, descriptionLabel, valueLabel].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            descriptionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-100),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-100),
            valueLabel.heightAnchor.constraint(equalToConstant: 40),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            valueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
            
        ])
    }
    
    func configure (model: CityDetailWeatherTableViewCellModel){
        descriptionLabel.text = model.description
        valueLabel.text = model.value
    }
}
