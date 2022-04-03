//
//  AppCoordinator.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
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
        self.presentReposScreen()
    }
    
    func presentReposScreen() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(ReposViewController.self, arguments: self, RepositoryType.main)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentRepoDetailsViewController(repo: Repo) {
        let viewController = Assembler.sharedAssembler.resolver.resolve(RepoDetailsViewController.self, arguments: self, RepositoryType.main, repo)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentOwnerDetailsViewController(repo: Repo) {
        let viewController = Assembler.sharedAssembler.resolver.resolve(OwnerDetailsViewController.self, arguments: self, RepositoryType.main, repo)!
        self.currentViewController?.present(viewController, animated: true)
    }
    
    func popTopViewController() {
        self.navigationController.popViewController(animated: true)
        self.currentViewController = self.navigationController.topViewController
    }
    
}
