//
//  DetailView.swift
//  BookArchive
//
//  Created by pankaj on 8/7/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView, DetailDisplayer {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(with viewState: BookViewState) {
        setupView()
        if let url = viewState.url {
            bookImageView.dowloadFromServer(url: url)
        }
        setNeedsLayout()
        authorLabel.text = viewState.author
        genreLabel.text = viewState.genre
        descriptionLabel.text = viewState.title
    }
    private func setupView(){
        bookImageView.setCornerRadiousAndBorder()
        authorLabel.setCornerRadiousAndBorder()
        genreLabel.setCornerRadiousAndBorder()
        descriptionLabel.setCornerRadiousAndBorder()
    }
}
