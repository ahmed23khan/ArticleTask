//
//  Article.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

// An Article Model
struct Article : Decodable {
    var adxKeywords:String
    var url:String
    var column:String?
    var section:String?
    var byline:String?
    var type:String?
    var title:String?
    var abstract:String?
    var date:String?
    var source:String?
    var id:Int?
    var assetId:Int?
    var views:Int?
    var descFacet:[String]?
    
    
    enum CodingKeys: String, CodingKey {
        case adxKeywords = "adx_keywords"
        case column
        case section
        case url
        case byline
        case type
        case abstract
        case date = "published_date"
        case source
        case id
        case assetId = "asset_id"
        case views
        case descFacet = "des_facet"
        case title
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adxKeywords = try values.decode(String.self, forKey: .adxKeywords)
        column = try values.decodeIfPresent(String.self, forKey: .column)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        url = try values.decode(String.self, forKey: .url)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        assetId = try values.decodeIfPresent(Int.self, forKey: .assetId)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        descFacet = try values.decodeIfPresent([String].self, forKey: .descFacet)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

// An Article Response Model
struct ArticleResponse : Decodable
{
    var status: String
    var copyright: String
    var numResults: Int
    var results: [Article]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(String.self, forKey: .status)
        copyright = try values.decode(String.self, forKey: .copyright)
        numResults = try values.decode(Int.self, forKey: .numResults)
        results = try values.decode([Article].self, forKey: .results)
    }
}

