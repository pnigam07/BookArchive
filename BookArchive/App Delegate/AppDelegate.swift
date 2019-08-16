//
//  AppDelegate.swift
//  BookArchive
//
//  Created by pankaj on 7/30/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate let mainNavigator: MainNavigator
    var window: UIWindow?
    
    override convenience init() {
        let mainNavigator = MainNavigator()
        self.init(mainNavigator: mainNavigator)
    }
    
    init(mainNavigator: MainNavigator) {
        self.mainNavigator = mainNavigator
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpWindow()
        guard let window = window else {
            return false
        }
        mainNavigator.toStart(inWindow: window)
        return true
    }
}

extension AppDelegate {
    func setUpWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
    }
}
