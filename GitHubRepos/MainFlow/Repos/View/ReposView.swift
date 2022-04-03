//
//  ReposView.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit

class ReposView: UIView, BaseView {
    
    let reposTableView = UITableView()
    let searchBar = SearchBar(placeholder: "Search for repository...")
    let reposImage = UIImageView(image: UIImage(named: "repo")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let emptyReposLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(reposImage)
        addSubview(emptyReposLabel)
        addSubview(reposTableView)
        addSubview(searchBar)
    }
    
    func styleSubviews() {
        reposTableView.backgroundColor = .clear
        reposTableView.rowHeight = ReposTableViewCell.rowHeight
        reposTableView.separatorStyle = .none
        reposTableView.showsVerticalScrollIndicator = false
        reposTableView.contentInsetAdjustmentBehavior = .never
        reposTableView.allowsSelection = true
        reposTableView.tableHeaderView = nil
        reposTableView.register(ReposTableViewCell.self, forCellReuseIdentifier: ReposTableViewCell.cellIdentifier)
        
        emptyReposLabel.text = "Find repository..."
        emptyReposLabel.textColor = UIColor(named: K.Color.main)
    }
    
    func positionSubviews() {
        searchBar.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        
        reposTableView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 90, left: 8, bottom: 0, right: 8))
        
        reposImage.centerInSuperview()
        reposImage.constrainWidth(80)
        reposImage.constrainHeight(80)
        
        emptyReposLabel.anchor(bottom: reposImage.topAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        emptyReposLabel.centerX(inView: self)
    }
    
    func hideKeyboard() {
        searchBar.searchTextField.endEditing(true)
    }
    
    func shouldHideEmptyListView(_ shouldHide: Bool) {
        emptyReposLabel.isHidden = shouldHide
        reposImage.isHidden = shouldHide
    }
    
}

