//
//  TidingsModel.swift
//  HLApp
//
//  Created by Роман on 05.04.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

protocol TidingsViewModelDelegate: class {
    func response(model: NewsResponse)
    func response(error: NSError)
}

enum TidingsCategoryType: String {
    case business = "business"
    case sports = "sport"
    case technology = "technology"
}

struct TidingsModelRequest: Encodable {
    let apiKey = "57e295f42ac141a8a5635c78c65bc4cf"
    var country = "us"
    var category = "character"
    var page = 1
    var pageSize = 7
    
    init(country: String? = "us", category: TidingsCategoryType) {
        self.country = country ?? "us"
        self.category = category.rawValue
    }
    
    mutating func setPage(value: Int) {
        self.page = value
    }
}

struct TidingsModelUI: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var content: String
    
    init(item: Article) {
        self.title = item.title ?? ""
        self.description = item.description ?? ""
        self.image = item.urlToImage ?? ""
        self.content = item.content ?? item.description ?? ""
    }
}

struct TidingsCategory: Identifiable {
    var id = UUID()
    var name: String
    var type: TidingsCategoryType
}
