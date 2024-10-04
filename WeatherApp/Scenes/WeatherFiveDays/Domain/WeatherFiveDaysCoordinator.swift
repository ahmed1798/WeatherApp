//
//  WeatherFiveDaysCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit

protocol WeatherFiveDaysTransitionDelegate: AnyObject {
    func back()
}
protocol WeatherFiveDaysChildDelegate: AnyObject {
    func didFinish(_ coordinator: NSObject)
}

final class WeatherFiveDaysCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private var window: UIWindow?
    var weather: WeatherList
    var rootViewController: UIViewController?
    weak var parentCoordinator: WeatherCoordinator?
    
    init(navigationController: UINavigationController,
         window: UIWindow?,
         weather: WeatherList) {
        self.navigationController = navigationController
        self.window = window
        self.weather = weather
    }
    
    func start() {
        let weatherFiveDaysViewModel = WeatherFiveDaysViewModel()
        weatherFiveDaysViewModel.weather = weather
        let controller = WeatherFiveDaysViewController(viewModel: weatherFiveDaysViewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}


// MARK: - WeatherFiveDaysTransitionDelegate
extension WeatherFiveDaysCoordinator: WeatherFiveDaysTransitionDelegate {
    func back() {
        parentCoordinator?.didFinish(self)
    }
}
