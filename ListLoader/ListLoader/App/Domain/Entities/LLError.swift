//
//  LLError.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

struct LLError: Decodable {
    let code: String?
    let message: String
    let details: String?
    let data: [String: String]?
}
