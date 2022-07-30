//
//  ImageRepository.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import RxSwift

protocol ImageRepositoryType {
    func searchImages(page: Int) -> Observable<SearchResult>
}


class ImageRepository {
    
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
}


extension ImageRepository: ImageRepositoryType {
    
    func searchImages(page: Int) -> Observable<SearchResult> {
        return Observable.create { [weak self] observer in
            let request = ImageService.searchImages(page: page)
            self?.networkManager.request(request, type: SearchResult.self) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
