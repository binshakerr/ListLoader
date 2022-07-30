//
//  Enums.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case userAgent = "User-Agent"
    case version = "Version"
}

enum ContentType: String {
    case json = "application/json"
    case string = "application/x-www-form-urlencoded"
}
