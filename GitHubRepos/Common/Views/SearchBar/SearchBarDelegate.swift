//
//  SearchBarDelegate.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation

protocol SearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: SearchBar, didSelectFilterOption filter: FilterOption)
}
