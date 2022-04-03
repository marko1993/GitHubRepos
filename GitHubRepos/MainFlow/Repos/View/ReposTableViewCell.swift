//
//  ReposTableViewCell.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit
import SDWebImage

protocol ReposTableViewCellDelegate: AnyObject {
    func reposTableViewCell(_ cell: ReposTableViewCell, didPressAvatar repo: Repo)
    func reposTableViewCell(_ cell: ReposTableViewCell, didPressOnCell repo: Repo)
}

class ReposTableViewCell: UITableViewCell, BaseView {
    
    static let cellIdentifier = "ReposTableViewCell"
    static let rowHeight: CGFloat = 150.0
    
    let container = UIView()
    let ownerAvatar = UIImageView()
    let ownerLabel = UILabel()
    let repoTitleLabel = UILabel()
    let borderView = UIView()
    let issuesTitleLabel = UILabel()
    let issuesLabel = UILabel()
    let forkImage = UIImageView(image: UIImage(named: "fork"))
    let forkLabel = UILabel()
    private var repo: Repo!
    weak var delegate: ReposTableViewCellDelegate?
    
    func addSubviews() {
        addSubview(container)
        container.addSubview(ownerAvatar)
        container.addSubview(ownerLabel)
        container.addSubview(repoTitleLabel)
        container.addSubview(borderView)
        container.addSubview(issuesTitleLabel)
        container.addSubview(issuesLabel)
        container.addSubview(forkImage)
        container.addSubview(forkLabel)
    }
    
    func styleSubviews() {
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = false
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 5.0
        container.layer.masksToBounds = true
        container.layer.borderWidth = 0.1
        container.layer.borderColor = UIColor(named: K.Color.main)?.cgColor
        
        ownerLabel.numberOfLines = 1
        ownerLabel.textColor = UIColor(named: K.Color.main)!
        ownerLabel.font = .boldSystemFont(ofSize: 22)
        
        repoTitleLabel.numberOfLines = 3
        repoTitleLabel.font = .systemFont(ofSize: 18)
        
        ownerAvatar.layer.cornerRadius = 25
        ownerAvatar.clipsToBounds = true
        ownerAvatar.layer.borderWidth = 2
        ownerAvatar.layer.borderColor = UIColor(named: K.Color.main)!.cgColor
        
        borderView.backgroundColor = UIColor(named: K.Color.main)!.withAlphaComponent(0.5)
        
        issuesLabel.textColor = .lightGray
        
        issuesTitleLabel.text = "Issues:"
        issuesTitleLabel.textColor = .lightGray
        
        forkLabel.textColor = .lightGray
    }
    
    func positionSubviews() {
        
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        
        ownerAvatar.anchor(top: container.topAnchor, leading: container.leadingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        ownerAvatar.constrainWidth(50)
        ownerAvatar.constrainHeight(50)
        
        ownerLabel.anchor(top: container.topAnchor, leading: ownerAvatar.trailingAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8))
        
        issuesLabel.anchor(bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4))
        
        issuesTitleLabel.anchor(bottom: container.bottomAnchor, trailing: issuesLabel.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4), size: CGSize(width: 60, height: 20))
        
        forkLabel.anchor(bottom: container.bottomAnchor, trailing: issuesTitleLabel.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 14))
        
        forkImage.anchor(bottom: container.bottomAnchor, trailing: forkLabel.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4), size: CGSize(width: 20, height: 20))
        
        borderView.anchor(leading: ownerAvatar.trailingAnchor, bottom: issuesTitleLabel.topAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
        borderView.constrainHeight(0.8)
        
        repoTitleLabel.anchor(top: ownerLabel.bottomAnchor, leading: ownerAvatar.trailingAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8))
    }
    
    private func setupBinding() {
        let avatarTap = UITapGestureRecognizer(target: self, action: #selector(onAvatarTap(tapGestureRecognizer:)))
        ownerAvatar.isUserInteractionEnabled = true
        ownerAvatar.addGestureRecognizer(avatarTap)
        
        let cellTap = UITapGestureRecognizer(target: self, action: #selector(onCellTap(tapGestureRecognizer:)))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(cellTap)
    }
    
    @objc func onAvatarTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.reposTableViewCell(self, didPressAvatar: repo)
    }
    
    @objc func onCellTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.reposTableViewCell(self, didPressOnCell: repo)
    }
    
    func setup(with repo: Repo) {
        self.repo = repo
        setupView()
        ownerLabel.text = repo.owner.login
        repoTitleLabel.text = repo.name
        issuesLabel.text = "\(repo.openIssuesCount ?? 0)"
        forkLabel.text = "\(repo.forks ?? 0)"
        if let stringUrl = repo.owner.avatarUrl,
           let url = URL(string: stringUrl) {
            ownerAvatar.sd_setImage(with: url, completed: nil)
        }
        setupBinding()
    }
    
}
