//
//  ServiceManager.swift
//  HLApp
//
//  Created by Роман on 17.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager {
    private var url = "http://newsapi.org/v2/top-headlines"
    
    func requestService<P: Encodable, R: Decodable>(paramenters: P, successful: @escaping (R) -> (), failure: @escaping (NSError) -> ()) {
        
        GlobalQueue.shared.queue.async {
            if NetworkReachabilityManager()?.isReachable ?? false {
                AF.request(self.url, method: .get, parameters: paramenters).responseJSON { response in
                    do {
                        guard let data = response.data else { return }
                        let model = try JSONDecoder().decode(R.self, from: data)
                        successful(model)
                    } catch {
                        failure(error as NSError)
                    }
                }
            } else {
                failure(NSError(domain: " NotInternetConnection", code: 100))
            } 
        }
    }
}
