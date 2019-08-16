//
//  ViewController.swift
//  BookArchive
//
//  Created by pankaj on 7/30/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UISearchControllerDelegate {
    
    var navigator: HomeNavigator?
    var presenter: HomePresenter
    var homeView: HomeView
    
    lazy var searchCoontroller: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = homeView.adapter
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    init(navigator: HomeNavigator) {
        let dataSource = HomeDataSource(fetcher: APIHomeFetcher())
        let useCase = HomeUseCase(dataSource: dataSource)

        self.homeView = HomeView()
        self.navigator = navigator
      
        self.presenter = HomePresenter(navigator: self.navigator,
                                       displayer: self.homeView,
                                       useCase: useCase)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeView)
        homeView.pinToSuperviewEdges()
       
        presenter.delegate = self
        navigationItem.title = "Book Store"
    }
    
    fileprivate func setUpNavigation(){
        
        navigationItem.rightBarButtonItem =
            NavigationBarFactory.setupSystemBarButtonWithTitle(title: "Reload",
                                                               target: self,
                                                               action: #selector(reloadData))
        navigationItem.searchController = searchCoontroller
 //       navigationController?.navigationBar.setNeedsLayout()
//        navigationController?.navigationBar.setNeedsDisplay()
//        navigationController?.navigationBar.layoutIfNeeded()
//        navigationController?.navigationBar.layoutSubviews()
    }
    
    @objc private func reloadData() {
        presenter.reloadData()
    }
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startPresenting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopPresenting()
    }
}

extension HomeViewController : PresenterDelegate {
    func updateNavigationBar() {
        DispatchQueue.main.async {
              self.setUpNavigation()
        }
      
    }

}

