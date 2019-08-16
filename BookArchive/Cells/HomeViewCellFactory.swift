//
//  HomeViewCellFactory.swift
//  BookArchive
//
//  Created by pankaj on 8/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class HomeViewCellFactory {
    
    static func registerViews(for tableView: UITableView) {
        tableView.register(TableViewCell<BookContentView>.self)
    }
    
    static func cell(for book: BookViewState,
                     at indexPath: IndexPath,
                     in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell<BookContentView>
        cell.reusableViewDelegate = cell.view
        cell.view.update(with: book)
        return cell
    }
}

