//
//  CityWeatherViewController.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

class CityDetailWeatherViewController: UIViewController {
    var currentWeather: Weather?
    
    private let exitButton = UIButton()
    private let tableView = UITableView()
    private let iconImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
    }
    
    private func setupElements() {
        exitButton.setupLittleButton(imageName: "", bgImageName: "arrow.left", tintColor: .gray)
        exitButton.addTarget(self, action: #selector(didClickedExitButton), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CityDetailWeatherTableViewCell.self, forCellReuseIdentifier: "CityDetailWeatherTableViewCell")
        tableView.register(CityDetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "CityDetailTableViewHeader")
        
        iconImageView.image = UIImage(named: currentWeather?.fact.icon ?? "bkn_d")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.zPosition = -1
        iconImageView.isUserInteractionEnabled = false
        
        [exitButton, tableView].forEach{
            view.addSubview($0)
        }
        addConstraints()
    }
    
    private func addConstraints() {
        [exitButton, tableView].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
  
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc func didClickedExitButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CityDetailWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailWeatherTableViewCell", for: indexPath) as? CityDetailWeatherTableViewCell else {
            return .init()
        }
        var model = CityDetailWeatherTableViewCellModel(description: "", value: "")
        
        switch indexPath.row{
        case 0:
            model = CityDetailWeatherTableViewCellModel(description: "Feels like:", value: String(format: "%.f", currentWeather?.fact.feels_like ?? 0.00) + "°C")
        case 1:
            model = CityDetailWeatherTableViewCellModel(description: "Wind speed:", value: String(format: "%.f", currentWeather?.fact.wind_speed ?? 0.00) + "km/h")
        case 2:
            model = CityDetailWeatherTableViewCellModel(description: "Pressure:", value: String(format: "%.f", currentWeather?.fact.pressure_mm ?? 0.00) + "mm")
        default:
            model = CityDetailWeatherTableViewCellModel(description: "", value: "")
        }
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CityDetailTableViewHeader") as? CityDetailTableViewHeader else {
            return .init()
        }
        let model = CityDetailTableViewHeaderModel(title: currentWeather?.geo_object.locality.name, condition: (currentWeather?.fact.condition)!, temperature: String(format: "%.f", currentWeather?.fact.temp ?? 0.00), icon: currentWeather?.fact.icon)
        header.configure(with: model)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
       
   }
