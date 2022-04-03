//
//  Owner.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

struct Owner: Codable {
    let id: Int
    let login: String
    let url: String
    let avatarUrl: String?
    let name: String?
    let bio: String?
    let htmlUrl: String?
}
