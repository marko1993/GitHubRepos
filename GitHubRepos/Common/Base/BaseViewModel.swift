//
//  BaseViewModel.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    var coordinator: Coordinator!
    var repository: RepositoryProtocol!
    
    let networkRequestState : BehaviorRelay<NetworkRequestState> = BehaviorRelay(value: .finished)
    let errorMessage : BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    init(repository: RepositoryProtocol, coordinator: Coordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func getAppCoordinator() -> AppCoordinator? {
        return coordinator as? AppCoordinator
    }
    
}
