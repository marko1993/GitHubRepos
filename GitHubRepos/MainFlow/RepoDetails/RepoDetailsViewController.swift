//
//  ReposDetailsViewController.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit
import RxSwift
import RxCocoa

class RepoDetailsViewController: BaseViewController {
    
    private let detailsView = RepoDetailsView()
    var viewModel: RepoDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(detailsView)
        setupBindings()
    }
    
    private func setupBindings() {
        bind(requestState: self.viewModel.networkRequestState.asObservable())
        
        detailsView.urlLabel.onTap(disposeBag: disposeBag) {
            if let url = URL(string: self.detailsView.urlLabel.text ?? "") {
                UIApplication.shared.open(url)
            }
        }
        
        detailsView.ownerAvatar.onTap(disposeBag: disposeBag) {
            self.viewModel.presentOwnerDetails()
        }
        
        viewModel.repoObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] repo in
                self?.detailsView.setup(with: repo)
            }).disposed(by: disposeBag)
        
        detailsView.closeImage.onTap(disposeBag: disposeBag) {
            self.viewModel.dismissController()
        }
    }
    
}
