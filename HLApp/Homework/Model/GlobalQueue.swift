//
//  GlobalQueue.swift
//  HLApp
//
//  Created by Роман on 21.07.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

class GlobalQueue {
    
    static let shared = GlobalQueue()
    var queue = DispatchQueue(label: "MyQueue", qos: .utility, attributes: .concurrent)
    
}
