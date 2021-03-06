//
// Article.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

public struct Article: Codable {
    
    public var title: String?
    public var description: String?
    public var urlToImage: String?
    public var content: String?

    public init(title: String, description: String, urlToImage: String, content: String) {
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.content = content
    }

}
