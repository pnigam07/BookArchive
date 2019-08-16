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
    func attachListener(listener: HomeActionListener)
    func detachListener()
}

protocol PresenterDelegate {
    func updateNavigationBar()
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
    
    func reloadData() {
        load()
    }

    func startPresenting() {
        attachListeners()
    }

    func stopPresenting() {
        displayer.detachListener()
    }
    
    private func attachListeners() {
        displayer.attachListener(listener: newListener())
    }
    
    private func newListener() -> HomeActionListener {
        return HomeActionListener(
            loadData: load,
            toDetailView: navigateToDetail
        )
    }
    
    private func navigateToDetail(viewState: BookViewState) {
        self.navigator?.toBookDetail(viewState: viewState)
    }
    
    func update(with viewState: BookViewStates) {
       delegate?.updateNavigationBar()
        self.displayer.update(with: viewState)
    }

    private func load() {
        useCase.load { (result) in
            switch result {
            case .success(let viewState):
                self.update(with: viewState)
            case .failure(let error):
                print(error)
                self.displayer.endLoading()
            }
        }
    }
}
