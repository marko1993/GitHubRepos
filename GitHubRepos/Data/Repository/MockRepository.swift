//
//  MockRepository.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

enum ApiCall {
    case fetchRepos
    case getOwner
}

class MockRepository: RepositoryProtocol {
    
    var isFetchGithubReposCalled = false
    var isGetOwnerCalled = false
    
    var fetchReposClosure: (([Repo]?, String?) -> Void)!
    var getOwnerClosure: ((Owner?, String?) -> Void)!
    
    func fetchGithubRepos(query: String, sortBy: String, completion: @escaping ([Repo]?, String?) -> Void) {
        isFetchGithubReposCalled = true
        fetchReposClosure = completion
    }
    
    func getOwner(login: String, completion: @escaping (Owner?, String?) -> Void) {
        isGetOwnerCalled = true
        getOwnerClosure = completion
    }
    
    func requestSuccess(apiCall: ApiCall) {
        apiCall == .fetchRepos ? fetchReposClosure([Repo()], nil) : getOwnerClosure(Owner(name: "Owner"), nil)
    }
    
    func requestFail(apiCall: ApiCall) {
        apiCall == .fetchRepos ? fetchReposClosure(nil, NetworkError.unknown.description) : getOwnerClosure(nil, NetworkError.unknown.description)
    }
    
}

