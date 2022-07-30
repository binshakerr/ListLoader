//
//  ImageService.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import Alamofire

fileprivate enum Constants: String {
    case baseURL = "https://pixabay.com/api/"
    case ApiKey = "28934953-c88802826a6d821fc568eed25"
}

enum ImageService {
    case searchImages(page: Int)
}

extension ImageService: EndPoint {
    
    var path: String {
        switch self {
        case .searchImages:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchImages:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchImages(let page):
            let parameters = ["key": Constants.ApiKey.rawValue, "page": page, "per_page": 20] as [String : Any]
            return parameters
        }
    }
    
    var baseURL: URL {
        return URL(string: Constants.baseURL.rawValue)!
    }
    
    var headers: [String : String] {
        return [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
        ]
    }
    
}
