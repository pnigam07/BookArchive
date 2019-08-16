//
//  Book.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

struct Books: Codable{
    let list: [Book]
}

//struct List: Codable {
//    <#fields#>
//}

struct Book: Codable {
    let id: String?
    let book_title: String?
    let author_name: String?
    let genre: String?
    let publisher: String?
    let author_country: String?
    let sold_count: Int?
    let image_url: URL?
}


