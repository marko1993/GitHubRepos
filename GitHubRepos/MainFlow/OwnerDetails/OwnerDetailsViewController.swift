//
//  OwnerDetailsViewController.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit
import RxSwift
import RxCocoa

class OwnerDetailsViewController: BaseViewController {
    
    private let ownerDetailsView = OwnerDetailsView()
    var viewModel: OwnerDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(ownerDetailsView)
        setupBindings()
    }
    
    private func setupBindings() {
        self.bind(requestState: self.viewModel.networkRequestState.asObservable())
        
        self.viewModel.ownerObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] owner in
                self?.ownerDetailsView.setup(with: owner)
            }).disposed(by: disposeBag)
        
        ownerDetailsView.urlLabel.onTap(disposeBag: disposeBag) {
            if let url = URL(string: self.ownerDetailsView.urlLabel.text ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
