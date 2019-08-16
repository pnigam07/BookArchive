//
//  HomeTableViewAdapter.swift
//  BookArchive
//
//  Created by pankaj on 8/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit

protocol xyz {
    func updateTableView()
}

class HomeTableViewAdapter: NSObject {
    
    fileprivate (set) var viewState = BookViewStates.initialState()
    fileprivate var actionListener: HomeActionListener?
    fileprivate var filterredList = BookViewStates.initialState()
    var delegate: xyz?
    
    func attachListener(listener: HomeActionListener) {
        actionListener = listener
    }
    
    func detachListener() {
        actionListener = nil
    }
    
    func update(with viewState: BookViewStates) {
        self.viewState = viewState
        filterredList = viewState
    }
}

extension HomeTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = filterredList.books[indexPath.row]
        actionListener?.toDetailView?(book)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeTableViewAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterredList.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = filterredList.books[indexPath.row]
        return HomeViewCellFactory.cell(for: book, at: indexPath, in: tableView)
    }
}

extension HomeTableViewAdapter:  UISearchBarDelegate {
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
         filterredList.books = viewState.books.filter({ (book) -> Bool in
           
            if (book.title?.lowercased().contains(searchText.lowercased()) ?? true  ||
                book.author?.lowercased().contains(searchText.lowercased())  ?? true ||
                book.genre?.lowercased().contains(searchText.lowercased()) ?? true)  {
                return true
            }
            return false
        })
        
        if searchText == ""{
            filterredList = viewState
        }
        
        delegate?.updateTableView()
        print(searchBar.text ?? "ff")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterredList = viewState
        delegate?.updateTableView()
    }
}

