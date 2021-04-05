//
//  WeatherInteractor.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherInteractor {
    weak var output: WeatherInteractorOutput?
    
    private let networkManager: NetworkManagerDescription
    
    init(networkManager: NetworkManagerDescription) {
           self.networkManager = networkManager
       }
}

extension WeatherInteractor: WeatherInteractorInput {
    func loadCurrentWeather(with city: String, for location: CLLocation, with displayType: String) {
        networkManager.currentWeather(for: location) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeather):
                    self?.output?.didLoadCurrentWeather(for: city, currentWeather: currentWeather, displayType: displayType)
                case .failure(let error):
                    self?.output?.didFail(with: error, for: city)
                }
            }
        }
    }
    
}

