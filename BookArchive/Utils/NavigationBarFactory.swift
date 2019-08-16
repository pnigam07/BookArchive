//
//  NavigationBarFactory.swift
//  BookArchive
//
//  Created by pankaj on 8/8/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class NavigationBarFactory: NSObject {
    
    static func setupBarButton(with image: UIImage?,
                               target: Any?,
                               action: Selector?,
                               renderingMode: UIImage.RenderingMode = .automatic) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            image: image?.withRenderingMode(renderingMode),
            style: .plain,
            target: target,
            action: action
        )
        return barButton
    }
    
    static func setupSystemBarButton(with type: UIBarButtonItem.SystemItem,
                                     target: Any?,
                                     action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: type,
                                        target: target,
                                        action: action)
        return barButton
    }
    
    static func setupSystemBarButtonWithTitle(title: String?,
                                            target: Any?,
                                            action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(title: title,
                                        style:.plain,
                                        target: target,
                                        action: action)
        barButton.tintColor = Constants.appTintColor
        return barButton
    }
    
    static func backBarButtonWithoutTitle() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        
        return barButton
    }
}

