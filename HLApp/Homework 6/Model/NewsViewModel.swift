//
//  NewsViewModel.swift
//  HLApp
//
//  Created by Роман on 15.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Combine
import Foundation

class NewsViewModel: ObservableObject {
    @Published var content = [NewsModelUI]()
    @Published var category: CategoryType = .sports {
        didSet {
            self.fetchNews()
        }
    }
    @Published var selectorIndex = 0
    @Published var categories = [Category(name: "Sports", type: .sports),
                                   Category(name: "Business", type: .business),
                                   Category(name: "Technology", type: .technology)]
    @Published var isAllUpdate: Bool = false
    @Published var isPaginationUpdate: Bool = false
    
    private var page: Int = 0
    
    init() {
        self.fetchNews()
    }
    
    func pageLoading() {
        self.page = self.page + 1
        var parameters = NewsModelRequest(category: self.category)
        parameters.page = self.page
        self.isPaginationUpdate = true
        ServiceManager().requestService(paramenters: parameters, successful: { [weak self] (model: NewsModelResponse) in
            guard let self = self else { return }
            self.isPaginationUpdate = false
            self.content.append(contentsOf: self.mapping(news: model.getArticles()))
        }, failure: { (error: NSError) in
            print(error)
        })
    }
    
    func uploadLocalContent() {
        self.content.removeAll()
        let dataBaseManager = DataBaseManager.shared
        if let model = dataBaseManager.loadDataBase(predicate: "category = '\(self.category.rawValue)'", type: NewsModelResponse.self) {
            self.content = self.mapping(news: model.getArticles())
        }
        self.isAllUpdate = false
    }
    
    private func mapping(news: [ArticleItem]) -> [NewsModelUI] {
        
        return news.compactMap { NewsModelUI(item: $0) }
    }
    
    private func fetchNews() {
        let parameters = NewsModelRequest(category: self.category)
        self.isAllUpdate = true
        self.page = 0
        ServiceManager().requestService(paramenters: parameters, successful: { [weak self] (model: NewsModelResponse) in
            let dataBaseManager = DataBaseManager.shared
            model.category = self?.category.rawValue
            dataBaseManager.saveDataBase(content: model)
            guard let self = self else { return }
            self.uploadLocalContent()
            self.page += self.page
        }, failure: { [weak self] (error: NSError) in
            self?.uploadLocalContent()
            print(error)
        })
    }
    
}
