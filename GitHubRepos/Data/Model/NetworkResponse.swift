//
//  NetworkResponse.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

struct ReposNetworkResponse: Decodable {
    let items: [Repo]
}
