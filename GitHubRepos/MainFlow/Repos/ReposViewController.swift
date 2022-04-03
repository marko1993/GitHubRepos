//
//  ReposViewController.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit
import RxSwift
import RxCocoa

class ReposViewController: BaseViewController {
    
    private let reposView = ReposView()
    var viewModel: ReposViewModel!
    var firstLoad = true
    
    override func viewDidLayoutSubviews() {
        if firstLoad {
            firstLoad = false
            setupBindings()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(reposView)
    }
    
    private func setupBindings() {
        bind(requestState: viewModel.networkRequestState.asObservable())
        bind(errorMessage: viewModel.errorMessage.asObservable())
        reposView.searchBar.delegate = self
        
        viewModel
            .reposObservable
            .observeOn(MainScheduler.instance)
            .bind(to:reposView.reposTableView.rx.items(cellIdentifier: ReposTableViewCell.cellIdentifier, cellType: ReposTableViewCell.self)) { index, data, cell in
                
                cell.delegate = self
                cell.setup(with: data)
        }.disposed(by: disposeBag)
        
        self.reposView.searchBar.searchTextField
            .rx.controlEvent([.editingChanged])
            .asObservable()
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.getRepos()
            }).disposed(by: disposeBag)
        
        self.reposView.reposTableView.rx.didScroll
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.reposView.hideKeyboard()
        }).disposed(by: disposeBag)
        
        self.viewModel.reposObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] repos in
                self?.reposView.shouldHideEmptyListView(repos.count > 0)
        }).disposed(by: disposeBag)
        
    }
    
    private func getRepos() {
        guard let query = self.reposView.searchBar.searchTextField.text, !query.isEmpty else { return }
        let filterOption = self.reposView.searchBar.selectedFilter
        self.viewModel.getRepos(query: query, filterOption: filterOption)
    }
    
}

extension ReposViewController: SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, didSelectFilterOption filter: FilterOption) {
        getRepos()
    }
}

extension ReposViewController: ReposTableViewCellDelegate {
    func reposTableViewCell(_ cell: ReposTableViewCell, didPressAvatar repo: Repo) {
        self.viewModel.presentOwnerDetialsScreen(repo: repo)
    }
    
    func reposTableViewCell(_ cell: ReposTableViewCell, didPressOnCell repo: Repo) {
        self.viewModel.presentRepoDetialsScreen(repo: repo)
    }
}
