//
//  Coordinator.swift
//  ListLoader
//
//  Created by Eslam Shaker on 31/07/2022.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}
