//
//  AuthenticationCoordinator.swift
//  ListLoader
//
//  Created by Eslam Shaker on 31/07/2022.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([makeLoginScreen()], animated: true)
    }
    
    private func makeLoginScreen() -> UIViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel, coordinator: self)
        return controller
    }
    
    func goToRegister() {
        let viewModel = RegisterViewModel()
        let controller = RegisterViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToHome() {
        sceneDelegate?.appCoordinator?.start()
    }
    
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
}
