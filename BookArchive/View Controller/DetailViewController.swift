//
//  DetailViewController.swift
//  BookArchive
//
//  Created by pankaj on 8/7/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter
    var detailView: DetailView
    var viewState: BookViewState
    
    init(viewState:BookViewState) {
        self.viewState = viewState
        detailView = {
            let viewController: UIViewController? = UIStoryboard(name: Constants.mainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as UIViewController
            guard let _ = viewController else { return UIView.init(frame: .zero) as! DetailView  }
            return viewController?.view as! DetailView
        }()
        
        self.presenter = DetailPresenter(viewState: viewState, displayer: detailView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(detailView)
         addSwipgesture()
        self.title = viewState.title
    }
    
    func addSwipgesture(){
      
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self,
                                                        action: #selector(self.handleSwipe(_:)))
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeftGesture)
    }
    
    @objc func handleSwipe(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
        print("its working")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startPresenting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopPresenting()
    }
}
