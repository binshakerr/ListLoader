//
//  ImageDetailsViewModel.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol ImageDetailsViewModelInputs: AnyObject {
    
}

protocol ImageDetailsViewModelOutputs: AnyObject {
    var screenTitle: String { get }
    var imageCellIdentifier: String { get }
    var userCellIdentifier: String { get }
    var items: BehaviorSubject<[TableViewSection]> { get }
    var dataSource: RxTableViewSectionedReloadDataSource<TableViewSection> { get }
}


protocol ImageDetailsViewModelProtocol: ImageDetailsViewModelInputs, ImageDetailsViewModelOutputs {
    var inputs: ImageDetailsViewModelInputs { get }
    var outputs: ImageDetailsViewModelOutputs { get }
}


final class ImageDetailsViewModel: ImageDetailsViewModelProtocol {
    
    var inputs: ImageDetailsViewModelInputs { self }
    var outputs: ImageDetailsViewModelOutputs { self }
    private var disposeBag = DisposeBag()
    var image: Image
    
    lazy var items = BehaviorSubject<[TableViewSection]>(value: [
        TableViewSection(items: [TableViewItem(image: image)]),
        TableViewSection(items: [TableViewItem(image: image)])
    ])
    
    let dataSource = ImageDataSource.dataSource()

    init(image: Image) {
        self.image = image
    }
    
    var screenTitle: String {
        "Image Details"
    }
    
    var imageCellIdentifier: String {
        "ImageDetailsCell"
    }
    
    var userCellIdentifier: String {
        "UserDetailsCell"
    }
    
    var numberOfSections: Int {
        2
    }
}
