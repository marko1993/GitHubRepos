//
//  SearchBar.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit

class SearchBar: UIView, BaseView {
    
    let containerView = UIView()
    let searchView = UIView()
    let searchImage = UIImageView(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let searchTextField = UITextField()
    let deleteImage = UIImageView(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    var placeholder: String = ""
    var filterStackView = UIStackView()
    var filterLabel = UILabel()
    var forksButton = UIButton()
    var starsButton = UIButton()
    var updatedButton = UIButton()
    var selectedFilter: FilterOption = .forks
    weak var delegate: SearchBarDelegate?
    
    init(placeholder: String = "") {
        self.placeholder = placeholder
        super.init(frame: .zero)
        setupView()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(searchView)
        searchView.addSubview(searchImage)
        searchView.addSubview(searchTextField)
        searchView.addSubview(deleteImage)
        containerView.addSubview(filterStackView)
        filterStackView.addArrangedSubview(filterLabel)
        filterStackView.addArrangedSubview(forksButton)
        filterStackView.addArrangedSubview(starsButton)
        filterStackView.addArrangedSubview(updatedButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        deleteImage.isHidden = true
        
        searchTextField.textColor = UIColor(named: K.Color.main)
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: K.Color.mainTransparent)!])
        
        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 20
        searchView.layer.borderColor = UIColor(named: K.Color.main)!.cgColor
        searchView.layer.borderWidth = 1
        
        filterLabel.text = "Filter"
        forksButton.setTitle("Forks", for: .normal)
        
        starsButton.setTitle("Stars", for: .normal)
        
        updatedButton.setTitle("Updated", for: .normal)
        setFilterOption(.forks)
        
        filterStackView.alignment = .center
        filterStackView.axis = .horizontal
        filterStackView.distribution = .equalSpacing
    }
    
    func positionSubviews() {
        self.constrainHeight(90)
        containerView.fillSuperview()
        
        searchView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 4, left: 14, bottom: 4, right: 14))
        searchView.constrainHeight(50)
        
        searchImage.anchor(leading: searchView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        searchImage.constrainHeight(16)
        searchImage.constrainWidth(16)
        searchImage.centerY(inView: searchView)
        
        deleteImage.anchor(trailing: searchView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12))
        deleteImage.constrainHeight(16)
        deleteImage.constrainWidth(16)
        deleteImage.centerY(inView: searchView)
        
        searchTextField.anchor(top: searchView.topAnchor, leading: searchImage.trailingAnchor, bottom: searchView.bottomAnchor, trailing: deleteImage.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
        filterStackView.anchor(top: searchView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        
    }
    
    func setupBindings() {
        let forksTap = UITapGestureRecognizer(target: self, action: #selector(onForksTap(tapGestureRecognizer:)))
        forksButton.addGestureRecognizer(forksTap)
        
        let starsTap = UITapGestureRecognizer(target: self, action: #selector(onStarsTap(tapGestureRecognizer:)))
        starsButton.addGestureRecognizer(starsTap)
        
        let updatedTap = UITapGestureRecognizer(target: self, action: #selector(onUpdatedTap(tapGestureRecognizer:)))
        updatedButton.addGestureRecognizer(updatedTap)
        
        let deleteTap = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(tapGestureRecognizer:)))
        deleteImage.isUserInteractionEnabled = true
        deleteImage.addGestureRecognizer(deleteTap)
        
        searchTextField.addTarget(self, action: #selector(SearchBar.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func onForksTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.setFilterOption(.forks)
    }
    
    @objc func onStarsTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.setFilterOption(.stars)
    }
    
    @objc func onUpdatedTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.setFilterOption(.updated)
    }
    
    @objc func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.clearSearchTextField()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let value = textField.text {
            self.deleteImage.isHidden = value.isEmpty
        } else {
            self.searchTextField.endEditing(true)
        }
    }
    
    private func setFilterOption(_ filter: FilterOption) {
        selectedFilter = filter
        forksButton.setTitleColor(UIColor(named: selectedFilter == .forks ? K.Color.main : K.Color.mainTransparent), for: .normal)
        starsButton.setTitleColor(UIColor(named: selectedFilter == .stars ? K.Color.main : K.Color.mainTransparent), for: .normal)
        updatedButton.setTitleColor(UIColor(named: selectedFilter == .updated ? K.Color.main : K.Color.mainTransparent), for: .normal)
        delegate?.searchBar(self, didSelectFilterOption: filter)
    }
    
    func clearSearchTextField() {
        self.searchTextField.text = ""
        self.deleteImage.isHidden = true
        self.searchTextField.endEditing(true)
    }
}
