//
//  Repo.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

struct Repo: Codable {
    let id: Int
    let name: String?
    var owner: Owner
    let description: String?
    let createdAt: String?
    let updatedAt: String?
    let language: String?
    let forks: Int?
    let watchers: Int?
    let openIssuesCount: Int?
    let htmlUrl: String?
}
