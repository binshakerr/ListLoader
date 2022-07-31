//
//  AppCoordinator.swift
//  ListLoader
//
//  Created by Eslam Shaker on 31/07/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigation = UINavigationController()
        
        if UserDefaults.standard.bool(forKey: "LoggedIn") {
            let homeCoordinator = HomeCoordinator(navigationController: navigation)
            childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        } else {
            let authCoordinator = AuthenticationCoordinator(navigationController: navigation)
            childCoordinators.append(authCoordinator)
            authCoordinator.start()
        }
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

