//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get }
    func start()
}

//: MARK: - APP COORDINATOR
class AppCoordinator: NSObject {
    
    //: MARK: - PROPERTIES
    var navigationController = UINavigationController()
    var rootViewController: UIViewController?
    private(set) var childCoordinators: [NSObject] = []
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    //: MARK: - START APP ROOT CONTROLLER
    func start() {
        let weatherCoordinator = WeatherCoordinator(navigationController: navigationController, window: window)
        childCoordinators.append(weatherCoordinator)
        weatherCoordinator.start()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

