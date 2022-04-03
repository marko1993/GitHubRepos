//
//  ReposDetailsViewModel.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

class RepoDetailsViewModel: BaseViewModel {
    
    private let repoRelay: BehaviorRelay<Repo>!
    var repoObservable: Observable<Repo> {
        return repoRelay.asObservable()
    }
    
    init(repository: RepositoryProtocol, coordinator: Coordinator, repo: Repo) {
        self.repoRelay = BehaviorRelay(value: repo)
        super.init(repository: repository, coordinator: coordinator)
        self.getOwner(login: repo.owner.login)
    }
    
    func getOwner(login: String) {
        self.networkRequestState.accept(.started)
        self.repository.getOwner(login: login, completion: { [weak self] owner, errorMessage in
            self?.networkRequestState.accept(.finished)
            if let error = errorMessage {
                self?.errorMessage.accept(error)
                return
            }
            if let owner = owner, var updatedRepo = self?.repoRelay.value {
                updatedRepo.owner = owner
                self?.repoRelay.accept(updatedRepo)
            }
        })
    }
    
    func presentOwnerDetails() {
        self.getAppCoordinator()?.presentOwnerDetailsViewController(repo: repoRelay.value)
    }
    
    func getOwnerName() -> String? {
        return repoRelay.value.owner.name
    }
    
    func dismissController() {
        self.getAppCoordinator()?.popTopViewController()
    }
    
}

