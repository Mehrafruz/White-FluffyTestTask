//
//  WeatherContainer.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class WeatherContainer {
    let input: WeatherModuleInput
    let viewController: UIViewController
    private(set) weak var router: WeatherRouterInput!

    class func assemble(with context: WeatherContext) -> WeatherContainer {
        let router = WeatherRouter()
        let interactor = WeatherInteractor(networkManager: NetworkManager.shared)
        let presenter = WeatherPresenter(router: router, interactor: interactor)
        let viewController = WeatherViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        router.viewController = viewController

        return WeatherContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: WeatherModuleInput, router: WeatherRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct WeatherContext {
    weak var moduleOutput: WeatherModuleOutput?
}

