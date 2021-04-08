//
//  WeatherPresenter.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherPresenter {
    weak var view: WeatherViewInput?
    weak var moduleOutput: WeatherModuleOutput?
    
    private let router: WeatherRouterInput
    private let interactor: WeatherInteractorInput
    
    private var cities: [String] = ["Moscow", "London", "New York", "Berlin", "Rome", "Bern", "Paris", "Monaco", "Stockholm", "Dublin"]
   //возможно не самое лаконичное решение, но мне кажется это тот случай когда дублирование оправдано (только если городов не будет значительно больше), я с радостью выслушаю Ваш фидбэк по этому кейсу :)
   private var defaultCities: [String] = ["Moscow", "London", "New York", "Berlin", "Rome", "Bern", "Paris", "Monaco", "Stockholm", "Dublin"]
    
    private var weatherByName: [String: Weather] = [:]
    
    
    init(router: WeatherRouterInput, interactor: WeatherInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WeatherPresenter: WeatherModuleInput {
}

extension WeatherPresenter: WeatherViewOutput {
    
    var itemCounts: Int {
        return cities.count
    }
    
    func display(at index: Int) -> CityTableViewCellModel {
        let city = cities[index]
        if let currentWeather = weatherByName[city] {
            return CityTableViewCellModel(title: currentWeather.geo_object.locality.name,
                                          condition: currentWeather.fact.condition,
                                          temperature: Int(currentWeather.fact.temp), icon: currentWeather.fact.icon)
        } else {
            loadWithCoordinate(city: city, displayType: "brief")
        }
    
        return CityTableViewCellModel(title: cities[index], condition: nil, temperature: nil, icon: nil)
    }
    
    func didTapAddButton() {
        router.showCityInput() { [weak self] city in
            guard let self = self, let city = city else {
                return
            }
            self.defaultCities.append(city)
            if let index = self.defaultCities.firstIndex(of: city) {
                self.cities = self.defaultCities
                self.view?.insert(at: index)
            }
        }
    }
    
    func didTapRemoveButton(at index: Int) {
        self.defaultCities.remove(at: index)
        self.cities = self.defaultCities
        self.view?.remove(at: index)
    }
    
    
    func didSelect(at index: Int) {
        if !cities.isEmpty{
            let city = cities[index]
            guard let currentWeather = weatherByName[city] else {
                return
            }
            router.show(currentWeather)
        }
    }
    

    func didSearch (with text: String) {
        if !text.isEmpty{
            let currentCities = defaultCities.filter({ cities -> Bool in
                return cities.lowercased().contains(text.lowercased())
            })
            cities = currentCities
            self.view?.update()
        } else {
            cities = defaultCities
            self.view?.update()
        }
    }
    
    
    func loadWithCoordinate(city: String, displayType: String){
        var location: CLLocation  = CLLocation(latitude: 0, longitude: 0)
        CLGeocoder().geocodeAddressString(city) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                location = placemarks?.first?.location ?? CLLocation(latitude: 0, longitude: 0)
                self.interactor.loadCurrentWeather(with: city, for: location, with: displayType)
            }
            else {
                self.didFail(with: error!, for: city)
            }
        }
    }
    
}

extension WeatherPresenter: WeatherInteractorOutput {
    func didLoadCurrentWeather(for city: String, currentWeather: Weather?, displayType: String) {
        if displayType == "brief"{
            weatherByName[city] = currentWeather
            if let index = cities.firstIndex(of: city) {
                view?.update(at: index)
            }
        } else
            if displayType == "detailed"{
                guard let weather = currentWeather else {
                    return
                }
                router.show(weather)
        }
    }
    
    func didFail(with error: Error, for city: String) {
        router.show(error)
        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
            view?.remove(at: index)
        }
    }
}

