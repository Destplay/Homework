//
//  HLAppTests.swift
//  HLAppTests
//
//  Created by Роман on 02.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import XCTest
@testable import HLApp

class HLAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMapping() {
        let viewModel = NewsViewModel()
        let article = NewsModelResponse.Article(source: NewsModelResponse.Article.Source(name: "source"), title: "title", articleDescription: "articleDescription", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        let newsUIModel = NewsModelUI(item: article)
        let newsUIModelMapping = viewModel.mapping(news: [article]).first
        XCTAssertEqual(newsUIModel, newsUIModelMapping)
    }

    func testMerge() {
        let viewModel = NewsViewModel()
        let array = ["Text1", "Text2", "Text3"]
        let text = viewModel.merge(array: array)
        var textSecondMerge = String()
        let _ = array.compactMap { textSecondMerge.append($0) }
        XCTAssert(text == textSecondMerge, "Текст не сходиться")        
    }
    
    func testClear() {
        let viewModel = NewsViewModel()
        viewModel.clear()
        XCTAssertFalse(viewModel.isAllUpdate)
        XCTAssertFalse(viewModel.isPaginationUpdate)
        XCTAssertEqual(viewModel.selectorIndex, 0)
        XCTAssertEqual(viewModel.page, 0)
    }

    func testNotNil() {
        let viewModel = NewsViewModel()
        let array = ["Text1", "Text2", "Text3"]
        XCTAssertNotNil(viewModel.check(array: array), "Пустое значение")
    }
}

extension NewsModelUI: Equatable {
    public static func ==(lhs: NewsModelUI, rhs: NewsModelUI) -> Bool {
        lhs.title == rhs.title && lhs.description == rhs.description && lhs.image == rhs.image && lhs.content == rhs.content
    }
}
