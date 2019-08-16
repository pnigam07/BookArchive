//
//  BookContentView.swift
//  BookArchive
//
//  Created by pankaj on 8/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

public class BookContentView: UIView, ReusableView {
    private let name = UILabel()
    private let author = UILabel()
    private let genre = UILabel()
    private let profilePicture = URLImageView()
    private let favourite = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
//        self.layer.borderColor = Constants.cellColor.cgColor
//        self.layer.borderWidth = 2
        
        addSubview(profilePicture)
        addSubview(name)
        addSubview(author)
        addSubview(genre)
     //   addSubview(favourite)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        profilePicture.addSizeConstraint(size: CGSize(width: 75, height: 75))
        profilePicture.pinToSuperview(edges: [.leading, .top, .bottom], constant: 8)
        
        name.pin(edge: .leading, to: .trailing, of: profilePicture, constant: 8)
        name.pinToSuperview(edges: [.trailing], constant: 8)
        name.pin(edge: .top, to: .top, of: profilePicture)
        
        author.pin(edge: .leading, to: .trailing, of: profilePicture, constant: 8)
        author.pin(edge: .top, to: .bottom, of: name, constant: 16)
        author.pinToSuperview(edges: [ .bottom], constant: 8)
        //author.pin(edge: .bottom, to: .bottom, of: profilePicture, constant: 8)
       
        genre.pin(edge: .leading, to: .trailing, of: author, constant: 8)
      //  genre.pin(edge: .trailing, to: .trailing, of: name, constant: 8)
        genre.pin(edge: .top, to: .bottom, of: name, constant: 16)
        genre.pinToSuperview(edges: [ .bottom, .trailing], constant: 8)
        
        genre.setWidthEqualToWidth(of: author)
        
    }
    
    func update(with viewState: BookViewState) {
        guard let profilePictureEndPoint = viewState.url else { return  }
        profilePicture.updateView(with: profilePictureEndPoint)
        name.text = viewState.title
        name.textAlignment = .center
        author.text = viewState.author
        author.textAlignment = .center
        genre.text = viewState.genre
        genre.textAlignment = .center
    }
    
    public func prepareForReuse() {
        profilePicture.reset()
    }
}

