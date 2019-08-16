//
//  MainNavigator.swift
//  BookArchive
//
//  Created by pankaj on 7/31/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class MainNavigator: NSObject {
    fileprivate let homeNavigator = HomeNavigator()
    fileprivate var window: UIWindow?
    
    func toStart(inWindow mainWindow: UIWindow) {
        window = mainWindow
        window?.backgroundColor = .white
        window?.rootViewController = homeNavigator.navigationController
        window?.makeKeyAndVisible()
    }
}
