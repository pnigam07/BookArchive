//
//  APIFactory.swift
//  ListingAndDetails
//
//  Created by pankaj on 7/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

enum APIFactory: APIRequest {
    case home
    case deatilPage(id: String)

    var path: String {
        switch self {
        case .home:
            return "/getAll"
        case .deatilPage(let id):
            return "/list/\(id).json"
        }
    }
    
    var method: Method {
        switch self {
        case .home, .deatilPage:
            return .GET
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .home, .deatilPage:
            return nil
//        case ./*add parameter needs to send in body*/:
//            return ["key": value]
        }
    }
    

}
