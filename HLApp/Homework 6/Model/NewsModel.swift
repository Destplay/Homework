//
//  NewsModel.swift
//  HLApp
//
//  Created by Роман on 30.05.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation
import RealmSwift

struct NewsModelRequest: Encodable {
    let apiKey = "57e295f42ac141a8a5635c78c65bc4cf"
    var country = "us"
    var category = "business"
    var page = 1
    var pageSize = 7
    
    init(country: String? = "us", category: CategoryType) {
        self.country = country ?? "us"
        self.category = category.rawValue
    }
    
    mutating func setPage(value: Int) {
        self.page = value
    }
}

struct NewsModelUI: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var content: String
    
    init(item: ArticleItem) {
        self.title = item.title ?? ""
        self.description = item.articleDescription ?? ""
        self.image = item.urlToImage ?? ""
        self.content = item.content ?? item.articleDescription ?? ""
    }
}

struct Category: Identifiable {
    var id = UUID()
    var name: String
    var type: CategoryType
}

class NewsModelResponse: Object, Codable {
    @objc dynamic var status: String?
    @objc dynamic var totalResults: Int = 0
    @objc dynamic var category: String?
    var articles = List<ArticleItem>()
    
    override class func primaryKey() -> String? {
        return "category"
    }
    
    func getArticles() -> [ArticleItem] {
        self.articles.compactMap( { $0 } )
    }
    
    private enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
    
}

class ArticleItem: Object, Codable {
    @objc dynamic var source: Source?
    @objc dynamic var title, articleDescription: String?
    @objc dynamic var url, urlToImage: String?
    @objc dynamic var publishedAt: String?
    @objc dynamic var content: String?
    
    private enum CodingKeys: String, CodingKey {
        case source, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

class Source: Object, Codable {
    @objc dynamic var name: String
}
