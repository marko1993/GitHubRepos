//
//  Owner.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

struct Owner: Codable {
    init(name: String? = nil) {
        self.id = 0
        self.login = ""
        self.url = ""
        self.avatarUrl = nil
        self.name = name
        self.bio = nil
        self.htmlUrl = nil
    }

    
    let id: Int
    let login: String
    let url: String
    let avatarUrl: String?
    let name: String?
    let bio: String?
    let htmlUrl: String?
}
