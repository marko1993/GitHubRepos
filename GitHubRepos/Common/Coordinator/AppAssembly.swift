//
//  AppAssembly.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        self.assembleMainRepository(container)
        self.assembleReposViewController(container)
        self.assembleRepoDetialsViewController(container)
        assembleOwnerDetialsViewController(container)
    }
    
    private func assembleMainRepository(_ container: Container) {
        
        container.register(NetworkService.self) { r in
            return NetworkService()
        }.inObjectScope(.container)
        
        container.register(RepositoryProtocol.self, name: RepositoryType.main.name) { r in
            let repository = MainRepository()
            repository.networkService = container.resolve(NetworkService.self)
            return repository
        }.inObjectScope(.container)
        
        container.register(RepositoryProtocol.self, name: RepositoryType.mock.name) { r in
            let repository = MockRepository()
            return repository
        }.inObjectScope(.container)
    }
    
    private func assembleReposViewController(_ container: Container) {
        container.register(ReposViewModel.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            return ReposViewModel(repository: container.resolve(RepositoryProtocol.self, name: repositoryType.name)!, coordinator: coordinator)
        }.inObjectScope(.transient)
        
        container.register(ReposViewController.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType) in
            let controller = ReposViewController()
            controller.viewModel = container.resolve(ReposViewModel.self, arguments: coordinator, repositoryType)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleRepoDetialsViewController(_ container: Container) {
        container.register(RepoDetailsViewModel.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType, repo: Repo) in
            return RepoDetailsViewModel(repository: container.resolve(RepositoryProtocol.self, name: repositoryType.name)!, coordinator: coordinator, repo: repo)
        }.inObjectScope(.transient)
        
        container.register(RepoDetailsViewController.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType, repo: Repo) in
            let controller = RepoDetailsViewController()
            controller.viewModel = container.resolve(RepoDetailsViewModel.self, arguments: coordinator, repositoryType, repo)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleOwnerDetialsViewController(_ container: Container) {
        container.register(OwnerDetailsViewModel.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType, repo: Repo) in
            return OwnerDetailsViewModel(repository: container.resolve(RepositoryProtocol.self, name: repositoryType.name)!, coordinator: coordinator, repo: repo)
        }.inObjectScope(.transient)
        
        container.register(OwnerDetailsViewController.self) { (resolver, coordinator: AppCoordinator, repositoryType: RepositoryType, repo: Repo) in
            let controller = OwnerDetailsViewController()
            controller.viewModel = container.resolve(OwnerDetailsViewModel.self, arguments: coordinator, repositoryType, repo)
            return controller
        }.inObjectScope(.transient)
    }
    
}

