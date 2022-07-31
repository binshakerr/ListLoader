//
//  HomeCoordinator.swift
//  ListLoader
//
//  Created by Eslam Shaker on 31/07/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([makeHomeScreen()], animated: true)
    }
    
    func makeHomeScreen() -> UIViewController {
        let repository = ImageRepository(networkManager: NetworkManager.shared)
        let viewModel = HomeViewModel(imageRepository: repository)
        let controller = HomeViewController(viewModel: viewModel, coordinator: self)
        return controller
    }
    
    func showImageDetailsFor(_ image: Image) {
        let viewModel = ImageDetailsViewModel(image: image)
        let controller = ImageDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
