//
//  Constants.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

struct K {
    
    struct Strings {
        static let appName = "GithubApp"
        static let ok = "Ok"
        static let search = "Search"
        static let updated = "Updated"
    }
    
    struct Networking {
        static let baseUrl = "https://api.github.com/"
        static let fetchReposEndpoint = "search/repositories"
        static let getUserDetailsEndpoint = "users/"
        static let queryParam = "q"
        static let sortParam = "sort"
        static let sortValue = "updated"
    }
    
    struct Color {
        static let main = "main"
        static let mainTransparent = "mainTransparent"
        static let mainLight = "mainLight"
    }
    
}
