//
//  AppAssembly.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        self.assembleMainRepository(container)
        self.assembleAuthenticateViewController(container)
        self.assembleTransactionsViewController(container)
    }
    
    private func assembleMainRepository(_ container: Container) {
        container.register(NetworkService.self) { r in
            return NetworkService()
        }.inObjectScope(.container)
        
        container.register(KeychainService.self) { r in
            return KeychainService()
        }.inObjectScope(.container)

        container.register(Repository.self, name: RepositoryType.main.name) { r in
            let repository = MainRepository(networkService: container.resolve(NetworkService.self)!, keychainService: container.resolve(KeychainService.self)!)
            return repository
        }.inObjectScope(.container)
    }
    
    private func assembleAuthenticateViewController(_ container: Container) {
        container.register(AuthenticateViewModel.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            return AuthenticateViewModel(repository: container.resolve(Repository.self, name: repositoryType.name)!, coordinator: coordinator)
        }.inObjectScope(.transient)
        
        container.register(AuthenticateViewController.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            let controller = AuthenticateViewController(viewModel: container.resolve(AuthenticateViewModel.self, arguments: coordinator, repositoryType)!)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleTransactionsViewController(_ container: Container) {
        container.register(TransactionsViewModel.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            return TransactionsViewModel(repository: container.resolve(Repository.self, name: repositoryType.name)!, coordinator: coordinator)
        }.inObjectScope(.transient)
        
        container.register(TransactionsViewController.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            let controller = TransactionsViewController(viewModel: container.resolve(TransactionsViewModel.self, arguments: coordinator, repositoryType)!)
            return controller
        }.inObjectScope(.transient)
    }
    
}
