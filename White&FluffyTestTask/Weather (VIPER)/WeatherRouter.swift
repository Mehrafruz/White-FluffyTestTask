//
//  WeatherRouter.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class WeatherRouter {
     weak var viewController: UIViewController?
}

extension WeatherRouter: WeatherRouterInput {
    func showCityInput(completion: @escaping (String?) -> Void) {
      let alertController = UIAlertController(title: "New city", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            completion(alertController.textFields?.first?.text)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        alertController.addTextField(configurationHandler: nil)
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func show(_ currentWeather: Weather) {
        let cityWeatherViewController = CityWeatherViewController()
        cityWeatherViewController.currentWeather = currentWeather
        viewController?.present(cityWeatherViewController, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        let message: String = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}

