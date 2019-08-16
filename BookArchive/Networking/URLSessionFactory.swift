//
//  URLSessionFactory.swift
//  ListingAndDetails
//
//  Created by pankaj on 7/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

final class URLSessionFactory {
    private let configuration: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    func makeSession() -> URLSession {
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
}
