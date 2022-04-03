//
//  ReposViewModel.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

class ReposViewModel: BaseViewModel {
    
    private let reposRelay: BehaviorRelay<[Repo]> = BehaviorRelay(value: [])
    var reposObservable: Observable<[Repo]> {
        return reposRelay.asObservable()
    }
    
    func getRepos(query: String, filterOption: FilterOption) {
        self.networkRequestState.accept(.started)
        self.repository.fetchGithubRepos(query: query, sortBy: filterOption.description, completion: { [weak self] repos, errorMessage in
            self?.networkRequestState.accept(.finished)
            if let error = errorMessage {
                self?.errorMessage.accept(error)
                self?.reposRelay.accept([])
                return
            }
            if let repos = repos {
                self?.reposRelay.accept(repos)
            }
        })
    }
    
    func getReposCount() -> Int {
        return reposRelay.value.count
    }
    
    func presentRepoDetialsScreen(repo: Repo) {
        self.getAppCoordinator()?.presentRepoDetailsViewController(repo: repo)
    }
    
    func presentOwnerDetialsScreen(repo: Repo) {
        self.getAppCoordinator()?.presentOwnerDetailsViewController(repo: repo)
    }
   
}

