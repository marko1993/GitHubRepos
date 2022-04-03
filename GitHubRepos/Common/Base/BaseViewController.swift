//
//  BaseViewController.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    private let loadingContainer = UIView()
    private let loadingIndicator = LoadingIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UITextField.appearance().tintColor = UIColor.systemTeal
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
    }
    
    func setupView(_ view: UIView) {
        self.view.backgroundColor = .white
        self.view.addSubview(view)
        view.fillSuperviewSafeAreaLayoutGuide()
    }
    
    func showLoading() {
        self.view.addSubview(loadingContainer)
        loadingContainer.fillSuperview()
        self.loadingIndicator.show()
    }
    
    func hideLoading() {
        self.loadingIndicator.hide()
        self.loadingContainer.removeFromSuperview()
    }
    
    private func setupLoadingView() {
        loadingContainer.addSubview(loadingIndicator)
        loadingContainer.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        loadingIndicator.centerInSuperview()
    }
    
    func presentInfoDialog(message: String) {
        let alert = UIAlertController(title: K.Strings.appName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.Strings.ok, style: UIAlertAction.Style.cancel, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func bind(requestState observable: Observable<NetworkRequestState>) {
        observable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .started:
                    self?.showLoading()
                case .finished:
                    self?.hideLoading()
                }
            }).disposed(by: disposeBag)
        rx.deallocating
            .withLatestFrom(observable)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.hideLoading()
            }).disposed(by: disposeBag)
    }
    
    func bind(errorMessage observable: Observable<String?>) {
        observable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorMessage in
                guard let errorMessage = errorMessage else { return }
                self?.presentInfoDialog(message: errorMessage)
            }).disposed(by: disposeBag)
    }
    
}

