//
//  ArticleViewModel.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class ArticleViewModel {
    
    // variable to hold model instance.
    var articleList:[Article]? = []
    
    private var cellViewModels: [ArticleCellViewModel] = [ArticleCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    // Call back to refresh TableView.
    var reloadTableViewClosure: (()->())?
    
    // Fetch cell count.
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // Method to fetch articles.
    func initFetch(){
        ArticleManager.defaultManager.fetchMostPopularArticles { [weak self] (result, error) in
            guard let response = result else {
                return
            }
            guard let weakSelf = self else { return }
            weakSelf.articleList = response
            weakSelf.processFetchedArticle(article: response)
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ArticleCellViewModel {
        return cellViewModels[indexPath.row]
    }
    // Configure Cell View Model.
    func createCellViewModel( article: Article ) -> ArticleCellViewModel {
        
        var articleTitle: String = String()
        var articleAbstract: String = String()
        var aritcleDate: String = String()
        
        if let title = article.title {
            articleTitle = title
        }
        if let abstract =  article.abstract {
            articleAbstract = abstract
        }
        if let date = article.date {
            aritcleDate = date
        }
       return ArticleCellViewModel(title: articleTitle, abstract: articleAbstract, date: aritcleDate)
    }
    // Configure Articles.
    private func processFetchedArticle( article: [Article] ) {
        var vms = [ArticleCellViewModel]()
        if let articleList = articleList {
            for article in articleList {
                vms.append( createCellViewModel(article: article) )
            }
            self.cellViewModels = vms
        }
    }
}

struct ArticleCellViewModel {
    let title: String
    let abstract: String
    let date: String
}
