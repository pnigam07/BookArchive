//
//  APIHomeFetcher.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

class APIHomeFetcher: HomeFetcher {
    
    private let apiService: APIService
    
    init(apiService: APIService = HTTPAPIService.standard) {
        self.apiService = apiService
    }
    
    func home(completionHandler:@escaping (Result<Data,Error>) -> Void)  {
        self.apiService.fetchJSON(request: APIFactory.home.urlRequest) { (result) in
            completionHandler(result)
        }
    }
}

