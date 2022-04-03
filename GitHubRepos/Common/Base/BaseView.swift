//
//  BaseView.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit

protocol BaseView where Self: UIView {
    func addSubviews()
    func styleSubviews()
    func positionSubviews()
}

extension BaseView {
    func setupView() {
        addSubviews()
        styleSubviews()
        positionSubviews()
    }
}
