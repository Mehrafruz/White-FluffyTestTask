//
//  CityWeatherViewController.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    var currentWeather: Weather?
    
    private let exitButton = UIButton()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let tempLabel = UILabel()
    private let feelsLikeLabel = UILabel()
    private let conditionLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let pressureLabel = UILabel()
    
    private let customLine0 = UITableViewCell()
    private let customLine1 = UITableViewCell()
    private let customLine2 = UITableViewCell()
    private let customLine3 = UITableViewCell()
    private let customLine4 = UITableViewCell()
    private let customLine5 = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
    }
    
    private func setupElements() {
        exitButton.setupLittleButton(imageName: "", bgImageName: "arrow.left", tintColor: .gray)
        exitButton.addTarget(self, action: #selector(didClickedExitButton), for: .touchUpInside)
        
        iconImageView.image = UIImage(named: currentWeather?.fact.icon ?? "bkn_d")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.zPosition = -1
        iconImageView.isUserInteractionEnabled = false
        
        [exitButton, titleLabel, iconImageView, tempLabel, feelsLikeLabel, conditionLabel, windSpeedLabel, pressureLabel, customLine0, customLine1, customLine2, customLine3, customLine4].forEach{
            view.addSubview($0)
        }
        
        titleLabel.font =  UIFont.systemFont(ofSize: 34, weight: .semibold)
        [tempLabel, feelsLikeLabel, conditionLabel, windSpeedLabel].forEach{
            ($0).font = UIFont.systemFont(ofSize: 24, weight: .regular)
        }
        
        titleLabel.text = currentWeather?.geo_object.locality.name ?? "How did you get it?"
        tempLabel.text = "Temperature: " + String(format: "%.f", currentWeather?.fact.temp ?? 0.00) + "°C"
        feelsLikeLabel.text = "Feels like: " + String(format: "%.f", currentWeather?.fact.feels_like ?? 0.00) + "°C"
        conditionLabel.text = "Condition: " + String(format: "%.f", currentWeather?.fact.pressure_mm ?? 0.00) + "mm"
        windSpeedLabel.text = " Wind speed: " + String(format: "%.f", currentWeather?.fact.wind_speed ?? 0.00) + "km/h"
                
        [customLine0, customLine1, customLine2, customLine3, customLine4, customLine5].forEach {
            ($0).backgroundColor = .lightGray
        }
        
        addConstraints()
    }
    
    private func addConstraints() {
        [exitButton, titleLabel, iconImageView, tempLabel, feelsLikeLabel, conditionLabel, windSpeedLabel, pressureLabel, customLine0, customLine1, customLine2, customLine3, customLine4].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = 50
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            iconImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2),
            iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            iconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: height),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -70),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            customLine0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            customLine0.heightAnchor.constraint(equalToConstant: 0.5),
            customLine0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            customLine0.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.heightAnchor.constraint(equalToConstant: height),
            tempLabel.topAnchor.constraint(equalTo: customLine0.bottomAnchor, constant: 5),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            customLine1.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            customLine1.heightAnchor.constraint(equalToConstant: 0.5),
            customLine1.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 0),
            customLine1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: height),
            feelsLikeLabel.topAnchor.constraint(equalTo: customLine1.bottomAnchor, constant: 5),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            customLine2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            customLine2.heightAnchor.constraint(equalToConstant: 0.5),
            customLine2.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 0),
            customLine2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.heightAnchor.constraint(equalToConstant: height),
            conditionLabel.topAnchor.constraint(equalTo: customLine2.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            customLine3.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            customLine3.heightAnchor.constraint(equalToConstant: 0.5),
            customLine3.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 0),
            customLine3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            windSpeedLabel.heightAnchor.constraint(equalToConstant: height),
            windSpeedLabel.topAnchor.constraint(equalTo: customLine3.bottomAnchor, constant: 5),
            windSpeedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            customLine4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50),
            customLine4.heightAnchor.constraint(equalToConstant: 0.5),
            customLine4.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 0),
            customLine4.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    @objc func didClickedExitButton() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}
