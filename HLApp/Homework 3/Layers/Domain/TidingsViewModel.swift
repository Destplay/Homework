//
//  NewsViewModel.swift
//  HLApp
//
//  Created by Роман on 29.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Combine
import UIKit

class TidingsViewModel: ObservableObject {
    @Published var content = [TidingsModelUI]()
    @Published var category: TidingsCategoryType = .sports {
        didSet {
            self.fetch()
        }
    }
    @Published var selectorIndex = 0
    @Published var categories = [TidingsCategory(name: "Sports", type: .sports),
                                   TidingsCategory(name: "Business", type: .business),
                                   TidingsCategory(name: "Technology", type: .technology)]
    @Published var isAllUpdate: Bool = false
    @Published var isPaginationUpdate: Bool = false
    
    private var page: Int = 0
    
    func fetch() {
        self.content.removeAll()
        self.page = 0
        var parameters = TidingsModelRequest(category: self.category)
        parameters.page = self.page
        self.isAllUpdate = true
        ServiceLocator.shared.getTidingsServices().fetchNews(parameters: parameters)
    }
    
    func pageLoading() {
        self.page = self.page + 1
        var parameters = TidingsModelRequest(category: self.category)
        parameters.page = self.page
        self.isPaginationUpdate = true
        ServiceLocator.shared.getTidingsServices().fetchNews(parameters: parameters)
    }
    
    func mapping(news: [Article]) -> [TidingsModelUI] {
        
        return news.compactMap { TidingsModelUI(item: $0) }
    }
}

extension TidingsViewModel: TidingsViewModelDelegate {
    func response(model: NewsResponse) {
        self.isPaginationUpdate = false
        self.isAllUpdate = false
        guard let articles = model.articles else { return }
        self.content.append(contentsOf: self.mapping(news: articles))
    }
    
    func response(error: NSError) {
        print(error.description)
    }
}
