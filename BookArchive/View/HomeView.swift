//
//  HomeView.swift
//  BookArchive
//
//  Created by pankaj on 8/1/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class HomeView: UIView, HomeDisplayer {

    private let tableView: UITableView
     let adapter = HomeTableViewAdapter()
    
    var actionListner: HomeActionListener?
    var loadMoreButton = UIButton.init(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override init(frame: CGRect) {
        
        self.tableView = UITableView(frame: .zero)
        super.init(frame: .zero)
        self.backgroundColor = .white
        activityIndicator.color = .gray
        self.setup()
        adapter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    func endLoading() {
//        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func update(with viewState: BookViewStates) {
        adapter.update(with: viewState)
        DispatchQueue.main.async {
            self.endLoading()
             self.setupViewWithListOfBooks()
        }
    }
    
    func setLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func attachListener(listener: HomeActionListener) {
        actionListner = listener
        adapter.attachListener(listener: listener)
    }
    
    func detachListener() {
        actionListner = nil
        adapter.detachListener()
    }
    
    private func setupViewWithListOfBooks() {
        self.endLoading()
        addSubViews()
        setupViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        addSubview(tableView)
        tableView.accessibilityIdentifier = "HomeTableView"
    }
    
    private func applyConstraints() {
        
        tableView.pinToSuperviewEdges()
        tableView.backgroundColor = .clear

        layoutIfNeeded()
        tableView.reloadData()
    }
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        HomeViewCellFactory.registerViews(for: tableView)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.estimatedRowHeight = 107.0
        tableView.tableFooterView = UIView()
    }
 
    private func setup(){
        self.addButton()
        addSubview(activityIndicator)
      //  activityIndicator.isHidden = true
    }
    
    private func addActivityIndicator(){
       
        activityIndicator.pinBottom(to: loadMoreButton)
        activityIndicator.pinCenterX(to: self)
        activityIndicator.isHidden = false
    }
    
    private func addButton(){
        loadMoreButton.setTitle("Load Books", for: .normal)
        loadMoreButton.setTitleColor(Constants.appTintColor, for: .normal)
        loadMoreButton.layer.cornerRadius = 5
        loadMoreButton.layer.borderWidth = 2
        loadMoreButton.layer.borderColor = UIColor.lightGray.cgColor
        loadMoreButton.addTarget(self, action: #selector(loading), for: .touchUpInside)
        self.addSubview(loadMoreButton)
        loadMoreButton.pinCenter(to: self)
        loadMoreButton.addSizeConstraint(size: CGSize.init(width: 150, height: 30))
    }
    
    @objc private func loading(){
        self.setLoading()
        actionListner?.loadData()
    }
    
    func endRefreshing() {
      //  activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        print("not loading")
    }
}

extension HomeView: xyz {
    func updateTableView() {
        tableView.reloadData()
    }
    
    
}

