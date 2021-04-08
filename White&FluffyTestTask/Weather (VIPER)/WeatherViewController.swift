//
//  WeatherViewController.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    private var tableView = UITableView()
    private var searcBar = UISearchBar()
    private var addButton = UIButton()
    
    private let output: WeatherViewOutput
    
    init(output: WeatherViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        searcBar.delegate = self
        searcBar.searchTextField.enablesReturnKeyAutomatically = false
        tableView.tableFooterView = UIView()
        tableView.register(CityWeatherTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        setupSearchBar()
        addButton.setupLittleButton(imageName: "", bgImageName: "plus", tintColor: .gray)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        [tableView, searcBar, addButton].forEach{
            view.addSubview($0)
        }
        addConstraint()
    }
    
    @objc
    private func didTapAddButton() {
        addButton.pulsate()
        if searcBar.text?.isEmpty ?? true{
            output.didTapAddButton()
        }
    }
    
    func addConstraint() {
        [tableView, searcBar, addButton].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            searcBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searcBar.heightAnchor.constraint(equalToConstant: 50),
            searcBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searcBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.leftAnchor.constraint(equalTo: searcBar.rightAnchor, constant: 10),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searcBar.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WeatherViewController: WeatherViewInput {
    func update(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func insert(at index: Int) {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func remove(at index: Int) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.itemCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityWeatherTableViewCell else {
            return .init()
        }
        let item = output.display(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelect(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            output.didTapRemoveButton(at: indexPath.row)
        }
    }
    
}

extension WeatherViewController: UISearchBarDelegate{
    func setupSearchBar() {
         searcBar.placeholder = "Madrid"
         searcBar.layer.cornerRadius = 10
         searcBar.alpha = 0.5
     }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            output.didSearch(with: searchText)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            output.didSelect(at: 0)
            //теперь мы ищем город в уже существующем списке
            //output.loadWithCoordinate(city: locationString, displayType: "detailed")
        }
        searchBar.endEditing(true)
    }
    
  
    
 
}

