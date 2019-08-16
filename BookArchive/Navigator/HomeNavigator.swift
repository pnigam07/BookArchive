//
//  HomeNavigator.swift
//  BookArchive
//
//  Created by pankaj on 7/31/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

protocol HomeViewNavigator {
    func toBookDetail(viewState: BookViewState)
}

class HomeNavigator {
    lazy var homeViewController: HomeViewController = {
        return HomeViewController(navigator: self)
    }()

    lazy var  navigationController: UINavigationController = {
        var navController = UINavigationController(rootViewController: homeViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = Constants.appTintColor
        return navController
    }()
}

extension HomeNavigator: HomeViewNavigator {
    func toBookDetail(viewState: BookViewState) {
        let viewController = DetailViewController(viewState: viewState)
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
