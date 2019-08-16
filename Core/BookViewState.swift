//
//  File.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

struct BookViewState {
    public let book: Book
    
    let title: String?
    let url: URL?
    let author: String?
    let genre: String?
    
    init(book: Book) {
        self.book = book
        
        self.title = book.book_title
        self.author = book.author_name
        self.genre = book.genre
        self.url = book.image_url
    }
}

struct BookViewStates: Equatable {
    
    static func == (lhs: BookViewStates, rhs: BookViewStates) -> Bool {
        return true
        //  return lhs.images.title == rhs.images.title && lhs.images.url == rhs.images.url
    }
    
    public var books: [BookViewState]
}

extension BookViewStates {
    
    static func initialState() -> BookViewStates{
        return BookViewStates(books: [])
    }
    
}
