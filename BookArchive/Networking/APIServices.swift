//
//  APIServices.swift
//  ListingAndDetails
//
//  Created by pankaj on 7/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol APIService {
    func fetchJSON(request: URLRequest?,completion:@escaping (_ result: Result<Data,Error>) -> Void)
}

protocol APIServicesDelegate {
    func didReceiveData(result:Result<Data, Error>)
}

class HTTPAPIService: APIService {
    private let urlSessionFactory: URLSessionFactory
    static let standard = HTTPAPIService(configuration: URLSessionConfigurationFactory.standard())
    
    init(configuration: URLSessionConfiguration) {
        self.urlSessionFactory = URLSessionFactory(configuration: configuration)
    }
    
    func fetchJSON(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let request = request {
            if !Reachability.isConnectedToNetwork(){
                let data :Data?
                if let key = request.url?.absoluteString {
                     data = UserDefaults.standard.value(forKey: key) as? Data
                    if let _ = data {
                        completion(.success(data ?? Data()))
                    }
                    else {
                        completion(.failure(NSError.init(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
                    }
                }
                else {
                    completion(.failure(NSError.init(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil)))
                }
            }
            else {
                let task = urlSessionFactory.makeSession().dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                else {
                        print(request.url?.absoluteString ?? "no value")
                        if let key = request.url?.absoluteString {
                            UserDefaults.standard.set(data, forKey: key)
                        }
                        completion(.success(data ?? Data()))
                    }
                }
                task.resume()
            }
        }
        else {
            completion(.failure(NSError.init(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil)))
        }
    }
}

final class URLSessionConfigurationFactory {
    private static let defaultTimeout = TimeInterval(30)
    private static let defaultDiskCapacity = 20 * 1024 * 1024
    static let standardCache = URLCache(memoryCapacity: 16 * 1024 * 1024,
                                        diskCapacity: defaultDiskCapacity,
                                        diskPath: "default")
    
    static func standard() -> URLSessionConfiguration {
        return createConfiguration(timeout: defaultTimeout,
                                   urlCache: standardCache,
                                   cachePolicy: .useProtocolCachePolicy)
    }
    
    private static func createConfiguration(timeout: TimeInterval,
                                            urlCache: URLCache,
                                            cachePolicy: NSURLRequest.CachePolicy) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = cachePolicy
        
        return configuration
    }
}
