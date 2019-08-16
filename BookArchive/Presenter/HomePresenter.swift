//
//  HomePresenter.swift
//  BookArchive
//
//  Created by pankaj on 7/31/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit

protocol HomeDisplayer {
    func endLoading()
    func update(with viewState: BookViewStates)
    func reloadTableView(with viewState: BookViewStates)
    func attachListener(listener: HomeActionListener)
    func detachListener()
}

protocol PresenterDelegate {
    func updateNavigationBar()
    func filteredAuthorName(rsultSet: Set<String>)
}

struct HomeActionListener {
    let loadData: () -> Void
    let toDetailView: ((BookViewState) -> Void)?
}

class HomePresenter {
    private let navigator: HomeViewNavigator?
    private let useCase: HomeUseCaseDataSource
    private var displayer: HomeDisplayer
    var delegate: PresenterDelegate?
    
    init(navigator: HomeViewNavigator?,
         displayer: HomeDisplayer,
         useCase: HomeUseCase) {
        
        self.navigator = navigator
        self.useCase = useCase
        self.displayer = displayer
    }
    
    // MARK: - Public Functions
    
    func showAuthorFilterView(){
        useCase.getFilteredAuther { (result) in
            self.delegate?.filteredAuthorName(rsultSet: result)
        }
    }
    
    func reset(){
        useCase.reset { (viewSate) in
            self.reload(with: viewSate)
        }
    }
    
    func startPresenting() {
        attachListeners()
    }

    func stopPresenting() {
        displayer.detachListener()
    }
    
    func filterListUsingTitle(authorName: String) {
        useCase.filter(authorName: authorName) { (viewSate) in
            self.reload(with: viewSate)
        }
    }
    // MARK: - Private Functions
    
    private func attachListeners() {
        displayer.attachListener(listener: newListener())
    }
    
    private func newListener() -> HomeActionListener {
        return HomeActionListener(
            loadData: load,
            toDetailView: navigateToDetail
        )
    }
    
    private func reload(with viewState: BookViewStates) {
        self.displayer.reloadTableView(with: viewState)
    }
    
    private func navigateToDetail(viewState: BookViewState) {
        self.navigator?.toBookDetail(viewState: viewState)
    }
    
    private func update(with viewState: BookViewStates) {
        self.displayer.update(with: viewState)
    }

    private func load() {
        useCase.load { (result) in
            switch result {
            case .success(let viewState):
                self.delegate?.updateNavigationBar()
                self.update(with: viewState)
            case .failure(let error):
                print(error)
                self.displayer.endLoading()
            }
        }
    }
}
