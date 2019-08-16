//
//  URLImageView.swift
//  BookArchive
//
//  Created by pankaj on 8/6/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit
import Foundation

typealias ImageCache = NSCache<NSString, UIImage>

class URLImageView: UIImageView {
    
    private let imageCache: ImageCache
    private var currentURL: URL?
    
    init(sharedImageCache: ImageCache = ImageCache()) {
        self.imageCache = sharedImageCache
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
     func updateView(with url: URL) {
        currentURL = url
     
        
        let key = url.absoluteString as NSString
        if let cached = imageCache.object(forKey: key) {
            image = cached
            return
        }
        
        let placeHolder = UIImage.init(named: "missing")
        
        return URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //print("RESPONSE FROM API: \(response)")
            if error != nil {
                print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        self.imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
    }
    
    func reset() {
        image = nil
        currentURL = nil
    }
    
}
