//
// NewsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



open class NewsAPI {
    /**
     news
     
     - parameter apiKey: (path) apiKey for news api 
     - parameter country: (path) news country 
     - parameter category: (path) news category 
     - parameter page: (path) news page 
     - parameter pageSize: (path) news page size 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func news(apiKey: String, country: String, category: String, page: Int, pageSize: Int, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: NewsResponse?,_ error: Error?) -> Void)) {
        newsWithRequestBuilder(apiKey: apiKey, country: country, category: category, page: page, pageSize: pageSize).execute(apiResponseQueue) { result -> Void in
            switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
            }
        }
    }

    /**
     news
     - GET /news
     - responseHeaders: [x-next(String)]
     - parameter apiKey: (path) apiKey for news api 
     - parameter country: (path) news country 
     - parameter category: (path) news category 
     - parameter page: (path) news page 
     - parameter pageSize: (path) news page size 
     - returns: RequestBuilder<NewsResponse> 
     */
    open class func newsWithRequestBuilder(apiKey: String, country: String, category: String, page: Int, pageSize: Int) -> RequestBuilder<NewsResponse> {
        var path = "?apiKey={apiKey}&country={country}&category={category}&page={page}&pageSize={pageSize}"
        let apiKeyPreEscape = "\(APIHelper.mapValueToPathItem(apiKey))"
        let apiKeyPostEscape = apiKeyPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{apiKey}", with: apiKeyPostEscape, options: .literal, range: nil)
        let countryPreEscape = "\(APIHelper.mapValueToPathItem(country))"
        let countryPostEscape = countryPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{country}", with: countryPostEscape, options: .literal, range: nil)
        let categoryPreEscape = "\(APIHelper.mapValueToPathItem(category))"
        let categoryPostEscape = categoryPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{category}", with: categoryPostEscape, options: .literal, range: nil)
        let pagePreEscape = "\(APIHelper.mapValueToPathItem(page))"
        let pagePostEscape = pagePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{page}", with: pagePostEscape, options: .literal, range: nil)
        let pageSizePreEscape = "\(APIHelper.mapValueToPathItem(pageSize))"
        let pageSizePostEscape = pageSizePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{pageSize}", with: pageSizePostEscape, options: .literal, range: nil)
        let urlString = OpenAPIClientAPI.basePath + path
        let parameters: [String: Any]? = nil

        let requestBuilder: RequestBuilder<NewsResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: urlString, parameters: parameters, isBody: false)
    }

}
