//
//  NewsServices.swift
//  HLApp
//
//  Created by Роман on 29.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

class TidingsServices {
    
    private weak var delegate: TidingsViewModelDelegate?
    
    init(delegate: TidingsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchNews(parameters: TidingsModelRequest) {
        NewsAPI.news(apiKey: parameters.apiKey, country: parameters.country, category: parameters.category, page: parameters.page, pageSize: parameters.pageSize) { (response, error) in
            if let error = error {
                self.delegate?.response(error: error as NSError)
            }
            guard let response = response else { self.delegate?.response(error: NSError()); return }
            
            self.delegate?.response(model: response)
            
        }
    }
}
