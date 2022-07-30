//
//  SearchResult.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

struct SearchResult: Decodable {
    let hits: [Image]
    let totalHits: Int
    let total: Int 
}
