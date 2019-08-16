//
//  HomeFetcher.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol HomeFetcher {
    func home(completionHandler: @escaping (Result<Data,Error>) -> Void)
}

