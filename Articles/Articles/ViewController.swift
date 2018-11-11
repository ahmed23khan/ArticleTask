//
//  ViewController.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Refresh Controller
    var refreshControl: UIRefreshControl!
    // View Model Instance.
    lazy var viewModel: ArticleViewModel = {
        return ArticleViewModel()
    }()
    // IBOutlets.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initialUiSetUp()
        self.registerNibs()
        self.initViewModel()
    }
    
    @objc func initViewModel() {
        
        if(self.refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
        // Naive binding to ViewModel.
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                if let activityIndicator = weakSelf.activityIndicator {
                    activityIndicator.removeFromSuperview()
                }
                weakSelf.articleTableView.reloadData()
            }
        }
        viewModel.initFetch()
    }
        
    // Method to setup UI.
    func initialUiSetUp(){
        // Setup the Search Controller
        self.activityIndicator.startAnimating()
    
        // Configure Referesh Control.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: PlaceHolder.PullRefresh)
        refreshControl.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        self.articleTableView.addSubview(refreshControl)
    }
    
    // Method to register NIBs.
    func registerNibs(){
        self.articleTableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
}

// MARK: - TableView Datasource.
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
        
        let cellViewModel = viewModel.getCellViewModel( at: indexPath )
        cell.configureCell(cellViewModel)
    
        return cell
    }
}

// MARK: - TableView Delegate.
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

