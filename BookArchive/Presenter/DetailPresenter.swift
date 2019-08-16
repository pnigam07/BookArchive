//
//  DetailPresenter.swift
//  BookArchive
//
//  Created by pankaj on 8/7/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol DetailDisplayer {
    func update(with viewState:BookViewState)
}

class DetailPresenter: NSObject {
    
    private let viewState: BookViewState
    private var displayer: DetailDisplayer
    
    init(viewState: BookViewState, displayer: DetailDisplayer) {
        self.viewState = viewState
        self.displayer = displayer
    }
    
    func startPresenting() {
        displayer.update(with: viewState)
    }
    func stopPresenting() {
        
    }
}
