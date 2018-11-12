//
//  DetailViewController.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 12/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    var articleList:[Article]? = []
    // vairable to hold filtered items.
     var filteredArticles:[Article] = []
    // Search Controller.
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerNibs()
        self.initialUiSetUp()
    }
    // Method to register NIBs.
    func registerNibs(){
        self.detailTableView.register(DetailTableViewCell.nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    // Method to setup UI.
    func initialUiSetUp(){
        // Setup the Search Controller
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .always
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder =  PlaceHolder.SearchBar
            self.navigationItem.searchController = searchController
            definesPresentationContext = true
        } else {
            // Fallback on earlier versions
        }
    }
}

// MARK: - SearchController Methods.
extension DetailViewController {
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if let articleList = articleList {
            filteredArticles = articleList.filter({(article : Article) -> Bool in
                let doesCategoryMatch = (scope == "All") || (article.title == scope)
                if searchBarIsEmpty() {
                    return doesCategoryMatch
                } else {
                    return doesCategoryMatch && article.title!.lowercased().contains(searchText.lowercased())
                }
            })
            self.detailTableView.reloadData()
        }
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articleList = articleList {
            if isFiltering() {
                return filteredArticles.count
            }
            return articleList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier , for: indexPath) as! DetailTableViewCell
        if isFiltering() {
            cell.ConfigureCell(filteredArticles[indexPath.row])
        } else {
            cell.ConfigureCell(articleList?[indexPath.row])
        }
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension DetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
