//
//  FilesManager.swift
//  HLApp
//
//  Created by Роман on 29.05.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

class FilesManager {
    
    static let shared = FilesManager()
    
    let manager = FileManager.default
    
    func saveFile<T: Codable>(name: String, content: T) {
        do {
            let data = try JSONEncoder().encode(content)
            let nameFile = name + ".txt"
            let dirFile = self.getDocumentsDirectory().appendingPathComponent(nameFile)
            try data.write(to: dirFile)
        } catch {
            print(error)
        }
        
    }
    
    func loadFile<T: Codable>(name: String, type: T.Type) -> T? {
        var content: T?
        
        do {
            let nameFile = name + ".txt"
            let dirFile = self.getDocumentsDirectory().appendingPathComponent(nameFile)
            let data = try Data(contentsOf: dirFile)
            content = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
        }
        
        return content
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = manager.urls(for: .cachesDirectory, in: .userDomainMask)

        return paths[0]
    }
}
