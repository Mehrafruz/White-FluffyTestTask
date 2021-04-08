//
//  WeatherProtocols.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherModuleInput {
    var moduleOutput: WeatherModuleOutput? { get }
}

protocol WeatherModuleOutput: class {
}

protocol WeatherViewInput: class {
    func update(at index: Int)
    func update ()
    func insert(at index: Int)
    func remove(at index: Int)
}

protocol WeatherViewOutput: class {
    var itemCounts: Int { get }
    func display(at index: Int) -> CityTableViewCellModel
    func didTapAddButton()
    func didTapRemoveButton(at index: Int)
    func didSelect(at index: Int)
    func didSearch (with text: String)
    func loadWithCoordinate(city: String, displayType: String)
}

protocol WeatherInteractorInput: class {
    func loadCurrentWeather(with city: String, for location: CLLocation, with displayType: String)
}

protocol WeatherInteractorOutput: class {
    func didLoadCurrentWeather(for city: String, currentWeather: Weather?, displayType: String)
    func didFail(with error: Error, for city: String)
}

protocol WeatherRouterInput: class {
    func showCityInput(completion: @escaping (String?) -> Void)
    func show(_ currentWeather: Weather)
    func show(_ error: Error)
}

