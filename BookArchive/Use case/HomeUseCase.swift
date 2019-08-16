//
//  HomeUseCase.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol HomeUseCaseDataSource {
    func load(completionHandler: @escaping (Result<BookViewStates,Error>) -> Void)
    func getFilteredAuther(completionHandler: @escaping (Set<String>) -> Void)
    func filter(authorName: String, completionBlock: @escaping (BookViewStates) -> Void)
    func reset(completionBlock: @escaping (BookViewStates) -> Void)
}

class HomeUseCase {
    
    var dataSource: HomeDataSourceProtocol
    private var viewState: BookViewStates?
    
    init(dataSource: HomeDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    private func viewStateFactory(books: Books) -> BookViewStates {
        let bookViewState = books.list.map { BookViewState(book: $0) }
        return BookViewStates(books: bookViewState)
    }
}

extension HomeUseCase: HomeUseCaseDataSource {
    
    func getFilteredAuther(completionHandler: @escaping (Set<String>) -> Void) {
        var resultSet = Set<String>()
        viewState?.books.forEach({ (bookViewState) in
            resultSet.insert(bookViewState.author ?? "")
        })
        completionHandler(resultSet)
    }
    
    func filter(authorName: String, completionBlock: @escaping (BookViewStates) -> Void) {
        let bookList = viewState!
        let list = bookList.books.filter { (viewState) -> Bool in
            if viewState.author?.lowercased().contains(authorName.lowercased()) ?? true {
                return true
            }
            return false
        }
        let filteredViewState = BookViewStates(books: list)
        completionBlock(filteredViewState)
    }
    
    func load(completionHandler: @escaping (Result<BookViewStates, Error>) -> Void) {
        dataSource.home { result in
            switch result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let imageList = try decoder.decode(Books.self, from: data)
                    self.viewState = self.viewStateFactory(books: imageList)
                    completionHandler(.success(self.viewState ?? BookViewStates.initialState()))
                    print(self.viewState ?? "No data")
                }
                catch {
                    print("Parsing error = \(error)")
                }
            }
        }
    }
    
    func reset(completionBlock: @escaping (BookViewStates) -> Void) {
        completionBlock(viewState ?? BookViewStates.initialState())
    }
}
