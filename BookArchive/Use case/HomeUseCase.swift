//
//  HomeUseCase.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol HomeUseCaseDataSource {
 //   func dataState() -> BookViewState
    func load(completionHandler: @escaping (Result<BookViewStates,Error>) -> Void)
}

class HomeUseCase: HomeUseCaseDataSource {
    var dataSource: HomeDataSourceProtocol
    
    init(dataSource: HomeDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func load(completionHandler: @escaping (Result<BookViewStates, Error>) -> Void) {
        
        dataSource.home { result in
            
            switch result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        data, options: [])
                //    print(jsonResponse) //Response result
                    let decoder = JSONDecoder()
                    let imageList = try decoder.decode(Books.self, from: data)
                    let viewState = self.viewStateFactory(books: imageList)
                    completionHandler(.success(viewState))
                    print(viewState)
                }
                catch {
                    print("Parsing error = \(error)")
                }
            }
        }
    }
    
    func viewStateFactory(books: Books) -> BookViewStates {
        let bookViewState = books.list.map { BookViewState(book: $0) }
        return BookViewStates(books: bookViewState)
    }
    
    
}
