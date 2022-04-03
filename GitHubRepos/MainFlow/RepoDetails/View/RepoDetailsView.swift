//
//  ReposDetailsView.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit

class RepoDetailsView: UIView, BaseView {
    
    let repoTitleLabel = UILabel()
    let ownerContainer = UIView()
    let ownerAvatar = UIImageView()
    let ownerNameLabel = UILabel()
    let ownerBioLabel = UILabel()
    let repoInfoStackView = UIStackView()
    let updatedLabel = UILabel()
    let updateDateLabel = UILabel()
    let starImage = UIImageView(image: UIImage(named: "star"))
    let starLabel = UILabel()
    let forkImage = UIImageView(image: UIImage(named: "fork"))
    let forkLabel = UILabel()
    let descriptionTextView = UITextView()
    let urlLabel = UILabel()
    let closeImage = UIImageView(image: UIImage(named: "cancel"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(repoTitleLabel)
        addSubview(ownerContainer)
        ownerContainer.addSubview(ownerAvatar)
        ownerContainer.addSubview(ownerNameLabel)
        ownerContainer.addSubview(ownerBioLabel)
        addSubview(repoInfoStackView)
        repoInfoStackView.addArrangedSubview(updatedLabel)
        repoInfoStackView.addArrangedSubview(updateDateLabel)
        repoInfoStackView.addArrangedSubview(forkImage)
        repoInfoStackView.addArrangedSubview(forkLabel)
        repoInfoStackView.addArrangedSubview(starImage)
        repoInfoStackView.addArrangedSubview(starLabel)
        addSubview(descriptionTextView)
        addSubview(urlLabel)
        addSubview(closeImage)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        repoTitleLabel.numberOfLines = 2
        repoTitleLabel.textColor = UIColor(named: K.Color.main)!
        repoTitleLabel.font = .boldSystemFont(ofSize: 22)
        repoTitleLabel.textAlignment = .center
        
        ownerAvatar.layer.cornerRadius = 25
        ownerAvatar.clipsToBounds = true
        ownerAvatar.layer.borderWidth = 2
        ownerAvatar.layer.borderColor = UIColor(named: K.Color.main)!.cgColor
        
        ownerNameLabel.numberOfLines = 1
        ownerNameLabel.font = .boldSystemFont(ofSize: 18)
        
        ownerBioLabel.numberOfLines = 3
        ownerBioLabel.font = .systemFont(ofSize: 12)
        ownerBioLabel.textColor = .lightGray
        
        repoInfoStackView.spacing = 5
        
        updatedLabel.text = K.Strings.updated
        updatedLabel.font = .systemFont(ofSize: 14)
        
        updateDateLabel.font = .systemFont(ofSize: 12)
        updateDateLabel.textColor = .lightGray
        
        forkLabel.font = .systemFont(ofSize: 12)
        forkLabel.textColor = .lightGray
        
        starLabel.font = .systemFont(ofSize: 12)
        starLabel.textColor = .lightGray
        
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = true
    }
    
    func positionSubviews() {
        closeImage.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 14, bottom: 20, right: 14), size: CGSize(width: 20, height: 20))
        
        ownerContainer.anchor(top: closeImage.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 7, bottom: 20, right: 7))
        ownerContainer.constrainHeight(84)
        
        ownerAvatar.anchor(top: ownerContainer.topAnchor, leading: ownerContainer.leadingAnchor, padding: UIEdgeInsets(top: 7, left: 7, bottom: 8, right: 7))
        ownerAvatar.constrainWidth(50)
        ownerAvatar.constrainHeight(50)
        
        ownerNameLabel.anchor(top: ownerAvatar.topAnchor, leading: ownerAvatar.trailingAnchor, trailing: ownerContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 7))
        
        ownerBioLabel.anchor(top: ownerNameLabel.bottomAnchor, leading: ownerAvatar.trailingAnchor, trailing: ownerContainer.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 7))
        
        repoTitleLabel.anchor(top: ownerContainer.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 14, bottom: 14, right: 14))
        
        urlLabel.anchor(top: repoTitleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
        repoInfoStackView.anchor(top: urlLabel.bottomAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        repoInfoStackView.centerX(inView: self)
        
        forkImage.constrainWidth(20)
        forkImage.constrainHeight(20)
        
        starImage.constrainWidth(20)
        starImage.constrainHeight(20)
        
        urlLabel.font = UIFont.systemFont(ofSize: 14)
        urlLabel.textAlignment = .center
        urlLabel.textColor = .link
        
        descriptionTextView.anchor(top: repoInfoStackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 14, bottom: 20, right: 14))
        
    }
    
    func setup(with repo: Repo) {
        repoTitleLabel.text = repo.name
        descriptionTextView.text = repo.description
        ownerNameLabel.text = repo.owner.name
        ownerBioLabel.text = repo.owner.bio
        starLabel.text = "\(repo.watchers ?? 0)"
        forkLabel.text = "\(repo.forks ?? 0)"
        urlLabel.text = "\(repo.htmlUrl ?? "")"
        
        if let date = ISO8601DateFormatter().date(from: repo.updatedAt ?? "") {
            let components = Calendar.current.dateComponents([.year, .day, .month, .day, .hour, .minute], from: date)
            updateDateLabel.text = getDateStringFromDateComponents(components)
        }
        
        if let stringUrl = repo.owner.avatarUrl,
           let url = URL(string: stringUrl) {
            ownerAvatar.sd_setImage(with: url, completed: nil)
        }
    }
    
    func getDateStringFromDateComponents(_ components: DateComponents) -> String {
        guard let year = components.year else { return "" }
        guard let day = components.day else { return "" }
        guard let month = components.month else { return "" }
        guard let hour = components.hour else { return "" }
        guard let minute = components.minute else { return "" }
        
        return "\(year)/\(day)/\(month) \(hour):\(minute)"
    }
    
}
