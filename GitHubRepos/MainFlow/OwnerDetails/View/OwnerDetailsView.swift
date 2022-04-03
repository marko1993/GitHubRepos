//
//  OwnerDetailsView.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit

class OwnerDetailsView: UIView, BaseView {
    
    let ownerContainer = UIView()
    let ownerAvatar = UIImageView()
    let ownerNameLabel = UILabel()
    let ownerBioLabel = UILabel()
    let urlLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(ownerContainer)
        ownerContainer.addSubview(ownerAvatar)
        ownerContainer.addSubview(ownerNameLabel)
        ownerContainer.addSubview(ownerBioLabel)
        ownerContainer.addSubview(urlLabel)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        ownerAvatar.layer.cornerRadius = 25
        ownerAvatar.clipsToBounds = true
        ownerAvatar.layer.borderWidth = 2
        ownerAvatar.layer.borderColor = UIColor(named: K.Color.main)!.cgColor
        
        ownerNameLabel.numberOfLines = 1
        ownerNameLabel.font = .boldSystemFont(ofSize: 18)
        
        ownerBioLabel.numberOfLines = 0
        ownerBioLabel.font = .systemFont(ofSize: 14)
        ownerBioLabel.textColor = .black
        
        urlLabel.font = UIFont.systemFont(ofSize: 14)
        urlLabel.textAlignment = .left
        urlLabel.textColor = .link
        
    }
    
    func positionSubviews() {
        
        ownerContainer.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 14, left: 7, bottom: 20, right: 7))
        ownerContainer.constrainHeight(84)
        
        ownerAvatar.anchor(top: ownerContainer.topAnchor, leading: ownerContainer.leadingAnchor, padding: UIEdgeInsets(top: 7, left: 7, bottom: 8, right: 7))
        ownerAvatar.constrainWidth(50)
        ownerAvatar.constrainHeight(50)
        
        ownerNameLabel.anchor(top: ownerAvatar.topAnchor, leading: ownerAvatar.trailingAnchor, trailing: ownerContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 7))
        
        ownerBioLabel.anchor(top: urlLabel.bottomAnchor, leading: ownerAvatar.trailingAnchor, trailing: ownerContainer.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 7))
        
        urlLabel.anchor(top: ownerNameLabel.bottomAnchor, leading: ownerAvatar.trailingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
    }
    
    func setup(with owner: Owner) {
        ownerNameLabel.text = owner.name
        ownerBioLabel.text = owner.bio
        urlLabel.text = owner.htmlUrl
        
        if let stringUrl = owner.avatarUrl,
           let url = URL(string: stringUrl) {
            ownerAvatar.sd_setImage(with: url, completed: nil)
        }
    }

}
