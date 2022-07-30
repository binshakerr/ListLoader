//
//  AppError.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

struct AppError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}
