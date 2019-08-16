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
    var creatBookLibraryButton = UIButton.init(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override init(frame: CGRect) {
        
        self.tableView = UITableView(frame: .zero)
        super.init(frame: .zero)
        self.backgroundColor = .white
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        self.setup()
        adapter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    func endLoading() {
        activityIndicator.stopAnimating()
    }
    
    func update(with viewState: BookViewStates) {
        adapter.update(with: viewState)
        DispatchQueue.main.async {
            self.endLoading()
             self.setupViewWithListOfBooks()
        }
    }
    
    func reloadTableView(with viewState: BookViewStates) {
        adapter.update(with: viewState)
        DispatchQueue.main.async {
          self.tableView.reloadData()
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
        creatBookLibraryButton.removeFromSuperview()
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
        addActivityIndicator()
    }
    
    private func addActivityIndicator(){
        addSubview(activityIndicator)
        activityIndicator.pinTop(to: self, constant: 250, priority: .required)
        activityIndicator.pinCenterX(to: self)
        activityIndicator.isHidden = true
    }
    
    private func addButton(){
        creatBookLibraryButton.setTitle("Create Book Library", for: .normal)
        creatBookLibraryButton.setTitleColor(Constants.appTintColor, for: .normal)
        creatBookLibraryButton.layer.cornerRadius = 5
        creatBookLibraryButton.layer.borderWidth = 0.5
        creatBookLibraryButton.layer.borderColor = Constants.appTintColor.cgColor
        creatBookLibraryButton.addTarget(self, action: #selector(loading), for: .touchUpInside)
        self.addSubview(creatBookLibraryButton)
        creatBookLibraryButton.pinCenter(to: self)
        creatBookLibraryButton.addSizeConstraint(size: CGSize.init(width: 150, height: 30))
    }
    
    @objc private func loading(){
        self.setLoading()
        actionListner?.loadData()
    }
    
    func endRefreshing() {
        activityIndicator.stopAnimating()
        print("not loading")
    }
}

extension HomeView: TableViewAdaptorDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
}

