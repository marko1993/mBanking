//
//  AppCoordinator.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit
import Swinject

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var currentViewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        presentAuthenticateScreen()
    }
    
    func presentAuthenticateScreen() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(AuthenticateViewController.self, arguments: self, RepositoryType.main)!
        self.currentViewController = viewController
        self.navigationController.setViewControllers([viewController], animated: true)
    }
    
    func presentTransactionsScreen() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(TransactionsViewController.self, arguments: self, RepositoryType.main)!
        self.currentViewController = viewController
        self.navigationController.setViewControllers([viewController], animated: true)
    }
    
}
