//
//  DataState.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation

enum DataState {
    case loading
    case finished(Outcome)
        
    enum Outcome {
        case failure(Error)
        case success
    }
}
