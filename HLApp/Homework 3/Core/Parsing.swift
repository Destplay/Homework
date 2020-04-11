//
//  Parsing.swift
//  HLApp
//
//  Created by Роман on 29.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

class Parsing {
    static let shared = Parsing()
    
    func parse<T: Decodable>(data: Data?, successes: @escaping (T) -> (), failure: @escaping (NSError) -> ()) {
        do {
            guard let data = data else { return }
            let model = try JSONDecoder().decode(T.self, from: data)
            successes(model)
        } catch let error as NSError {
            failure(error)
        }
    }
}
