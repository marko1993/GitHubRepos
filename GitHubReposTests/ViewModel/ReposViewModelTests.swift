//
//  ReposViewModelTests.swift
//  GitHubReposTests
//
//  Created by Marko Matijević on 03.04.2022..
//

import XCTest
import Swinject
@testable import GitHubRepos

class ReposViewModelTests: XCTestCase {
    
    var sut: ReposViewModel!

    override func setUp() {
        super.setUp()
        let coordinator = AppCoordinator(navigationController: UINavigationController())
        sut = Assembler.sharedAssembler.resolver.resolve(ReposViewModel.self, arguments: coordinator, RepositoryType.mock)!
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchRepos_called() {
        sut.getRepos(query: "iOS", filterOption: .forks)
        
        XCTAssert((sut.repository as! MockRepository).isFetchGithubReposCalled)
    }
    
    func test_fetchRepos_requestSuccess() {
        sut.getRepos(query: "iOS", filterOption: .forks)
        
        (sut.repository as! MockRepository).requestSuccess(apiCall: .fetchRepos)
        
        XCTAssertEqual(1, sut.getReposCount())
    }
    
    func test_fetchRepos_requestFail() {
        sut.getRepos(query: "iOS", filterOption: .forks)
        
        (sut.repository as! MockRepository).requestFail(apiCall: .fetchRepos)
        
        XCTAssertEqual(0, sut.getReposCount())
        XCTAssertEqual(sut.errorMessage.value, NetworkError.unknown.description)
    }
    
    func test_networkRequestState_whenRequestIsSuccessfull() {
        XCTAssertEqual(sut.networkRequestState.value, .finished)
        
        sut.getRepos(query: "iOS", filterOption: .forks)
        XCTAssertEqual(sut.networkRequestState.value, .started)
        
        (sut.repository as! MockRepository).requestSuccess(apiCall: .fetchRepos)
        XCTAssertEqual(sut.networkRequestState.value, .finished)
    }
    
    func test_networkRequestState_whenRequestFailed() {
        XCTAssertEqual(sut.networkRequestState.value, .finished)
        
        sut.getRepos(query: "iOS", filterOption: .forks)
        XCTAssertEqual(sut.networkRequestState.value, .started)
        
        (sut.repository as! MockRepository).requestFail(apiCall: .fetchRepos)
        XCTAssertEqual(sut.networkRequestState.value, .finished)
    }

}
