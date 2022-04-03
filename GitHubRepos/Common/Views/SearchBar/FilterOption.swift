//
//  SearchOption.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

enum FilterOption {
    case forks, stars, updated
    
    public var description: String {
        switch self {
        case .forks:
            return "forks"
        case .stars:
            return "stars"
        case .updated:
            return "updated"
        }
    }
}
