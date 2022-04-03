//
//  MainRepository.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

class MainRepository: RepositoryProtocol {
    
    var networkService: NetworkService!
    let disposeBag = DisposeBag()
    
    func fetchGithubRepos(query: String, sortBy: String, completion: @escaping ([Repo]?, String?) -> Void) {
        let resources = Resources<ReposNetworkResponse, EmptyRequestBody>(
            path: K.Networking.fetchReposEndpoint,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: [K.Networking.queryParam: query,
                              K.Networking.sortParam: sortBy]
        )
        networkService.performRequest(resources: resources, retryCount: 1)
            .subscribe(onNext: { response in
                completion(response.items, nil)
            }, onError: { error in
                completion(nil, error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func getOwner(login: String, completion: @escaping (Owner?, String?) -> Void) {
        let resources = Resources<Owner, EmptyRequestBody>(
            path: "\(K.Networking.getUserDetailsEndpoint)\(login)",
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        networkService.performRequest(resources: resources, retryCount: 1)
            .subscribe(onNext: { response in
                completion(response, nil)
            }, onError: { error in
                completion(nil, error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
}
