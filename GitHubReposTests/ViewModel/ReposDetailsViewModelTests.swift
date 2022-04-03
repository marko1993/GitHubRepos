//
//  ReposDetailsViewModelTests.swift
//  GitHubReposTests
//
//  Created by Marko Matijević on 03.04.2022..
//

import XCTest
import Swinject
@testable import GitHubRepos

class ReposDetailsViewModelTests: XCTestCase {

    var sut: RepoDetailsViewModel!

    override func setUp() {
        super.setUp()
        let coordinator = AppCoordinator(navigationController: UINavigationController())
        let repo = Repo()
        sut = Assembler.sharedAssembler.resolver.resolve(RepoDetailsViewModel.self, arguments: coordinator, RepositoryType.mock, repo)!
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getOwner_called() {
        sut.getOwner(login: "ownerLogin")
        
        XCTAssert((sut.repository as! MockRepository).isGetOwnerCalled)
    }
    
    func test_getOwner_requestSuccess() {
        sut.getOwner(login: "ownerLogin")

        (sut.repository as! MockRepository).requestSuccess(apiCall: .getOwner)

        XCTAssertEqual("Owner", sut.getOwnerName())
    }

    func test_getOwner_requestFail() {
        sut.getOwner(login: "ownerLogin")

        (sut.repository as! MockRepository).requestFail(apiCall: .getOwner)

        XCTAssertEqual(sut.errorMessage.value, NetworkError.unknown.description)
    }

    func test_networkRequestState_whenRequestIsSuccessfull() {
        sut.getOwner(login: "ownerLogin")
        XCTAssertEqual(sut.networkRequestState.value, .started)

        (sut.repository as! MockRepository).requestSuccess(apiCall: .getOwner)
        XCTAssertEqual(sut.networkRequestState.value, .finished)
    }

    func test_networkRequestState_whenRequestFailed() {
        sut.getOwner(login: "ownerLogin")
        XCTAssertEqual(sut.networkRequestState.value, .started)

        (sut.repository as! MockRepository).requestFail(apiCall: .getOwner)
        XCTAssertEqual(sut.networkRequestState.value, .finished)
    }

}

