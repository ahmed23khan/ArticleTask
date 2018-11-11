//
//  ArticleManager.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class ArticleManager: NSObject {
    
    // Singleton Class to Network Transcations.
    static let defaultManager = ArticleManager()
    
    typealias articlesCompletion = ( _ results:[Article]?,_ error:Error?) -> ()
    
    // Method to fetch Articles.
    func fetchMostPopularArticles(completionHandler: @escaping articlesCompletion){
        let url = URL(string: ArticleAPI.fetchMostPopularArticlesAPI(section: "all-sections", period: 7))
        if let url = url {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data else {
                    print(ErrorConstants.DataError)
                    completionHandler(nil, error)
                    return
                }
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ArticleResponse.self, from: responseData)
                    completionHandler(response.results, nil)
                } catch {
                    print(ErrorConstants.JsonParseError)
                    print(error)
                    completionHandler(nil, error)
                }
                }.resume()
        }
    }
}

// Construct URL.
struct ArticleAPI {
    
    // API Key
    static func apiKey() -> String {
        return UrlConstants.ApiKey
    }
    
    // End Point URL
    static func baseEndPoint() -> String {
        return UrlConstants.BaseUrl
    }
    
    // Invoking API
    static func fetchMostPopularArticlesAPI(section:String,period:Int) -> String {
        return "\(self.baseEndPoint())\(section)/\(period).json?api-key=\(self.apiKey())"
    }
}
