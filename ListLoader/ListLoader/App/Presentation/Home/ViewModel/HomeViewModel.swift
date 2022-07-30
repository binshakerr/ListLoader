//
//  HomeViewModel.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelInputs: AnyObject {
    func searchImages()
    func refreshContent()
//    PublishSubject<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var dataSubject: BehaviorRelay<[Image]> { get }
    var stateSubject: BehaviorRelay<DataState?> { get }
    var errorSubject: BehaviorRelay<String?> { get }
    var screenTitle: String { get }
    var cellIdentifier: String { get }
}


protocol HomeViewModelProtocol: HomeViewModelInputs, HomeViewModelOutputs {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var inputs: HomeViewModelInputs { self }
    var outputs: HomeViewModelOutputs { self }
    
    //MARK: - Inputs
    let searchSubject = PublishSubject<String>()
    
    //MARK: - Outputs
    let cellIdentifier = "ImageListCell"
    let screenTitle = "Pixabay Images"
    let dataSubject = BehaviorRelay<[Image]>(value: [])
    let stateSubject = BehaviorRelay<DataState?>(value: nil)
    let errorSubject = BehaviorRelay<String?>(value: nil)
    private var currentPage = 1
    
    //MARK: -
    private let imageRepository: ImageRepositoryType
    private let disposeBag = DisposeBag()
    
    init(imageRepository: ImageRepositoryType) {
        self.imageRepository = imageRepository
        bindInputs()
    }
    
    func bindInputs() {
//        inputs
//            .searchSubject
//            .subscribe(onNext: { [weak self] searchTerm in
//                //                self?.searchObjects(keyword: searchTerm)
//            })
//            .disposed(by: disposeBag)
    }
    
    func searchImages() {
        stateSubject.accept(.loading)
        imageRepository.searchImages(page: currentPage)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.stateSubject.accept(response.total > 0 ? .populated : .empty)
                self.dataSubject.accept(response.hits)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.stateSubject.accept(.error)
                self.errorSubject.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func refreshContent() {
        currentPage = 1
        stateSubject.accept(nil)
        dataSubject.accept([])
        searchImages()
    }
}
