//
//  HomeDataSource.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol HomeDataSourceProtocol {
    func home(completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class HomeDataSource: HomeDataSourceProtocol {
    private let fetcher: HomeFetcher
    
    public init(fetcher: HomeFetcher) {
        self.fetcher = fetcher
    }
    
    public func home(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        fetcher.home(completionHandler: { (result) in
            completionHandler(result)
        })
    }
}
