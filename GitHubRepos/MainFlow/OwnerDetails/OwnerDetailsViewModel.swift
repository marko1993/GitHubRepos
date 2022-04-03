//
//  OwnerDetailsViewModel.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

class OwnerDetailsViewModel: BaseViewModel {
    
    private let ownerRelay: BehaviorRelay<Owner>!
    var ownerObservable: Observable<Owner> {
        return ownerRelay.asObservable()
    }
    
    init(repository: RepositoryProtocol, coordinator: Coordinator, repo: Repo) {
        self.ownerRelay = BehaviorRelay(value: repo.owner)
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
            if let owner = owner {
                self?.ownerRelay.accept(owner)
            }
        })
    }
}
