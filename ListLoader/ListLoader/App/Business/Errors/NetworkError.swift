//
//  NetworkError.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

struct NetworkError: LocalizedError {
    let errorResponse: ErrorResponse
    
    var errorDescription: String? {
        return NSLocalizedString(errorResponse.error.message, comment: "")
    }
}
