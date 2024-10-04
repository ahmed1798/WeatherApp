//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit

protocol WeatherTransitionDelegate: AnyObject {
    func navigateToWeatherFiveDays(weather: WeatherList)
}
protocol WeatherChildDelegate: AnyObject {
    func didFinish(_ coordinator: NSObject)
}

final class WeatherCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private var window: UIWindow?
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController,
         window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        let weatherViewModel = WeatherViewModel()
        let controller = WeatherViewController(viewModel: weatherViewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - WeatherTransitionDelegate
extension WeatherCoordinator: WeatherTransitionDelegate {
    func navigateToWeatherFiveDays(weather: WeatherList) {
        let weatherFiveDaysCoordinator = WeatherFiveDaysCoordinator(navigationController: navigationController, window: window, weather: weather)
        weatherFiveDaysCoordinator.parentCoordinator = self
        childCoordinators.append(weatherFiveDaysCoordinator)
        weatherFiveDaysCoordinator.start()
    }
}

// MARK: - WeatherChildDelegate
extension WeatherCoordinator: WeatherChildDelegate {
    func didFinish(_ coordinator: NSObject) {
        if let index = childCoordinators.firstIndex(where: { childCoordinator in
            childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            navigationController.popViewController(animated: true)
        }
    }
}


