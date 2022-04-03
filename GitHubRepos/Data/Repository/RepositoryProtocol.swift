//
//  RepositoryProtocol.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

enum RepositoryType {
    case main, mock
    
    var name: String {
        switch self {
        case .main:
            return "main"
        case .mock:
            return "mock"
        }
    }
}

protocol RepositoryProtocol {
    func fetchGithubRepos(query: String, sortBy: String, completion: @escaping ([Repo]?, String?) -> Void)
    func getOwner(login: String, completion: @escaping (Owner?, String?) -> Void)
}

