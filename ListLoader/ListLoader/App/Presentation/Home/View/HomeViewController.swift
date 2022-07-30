//
//  HomeViewController.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: viewModel.cellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellIdentifier)
        table.rowHeight = 70
        table.refreshControl = refreshControl
        return table
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refreshContent(_:)), for: .valueChanged)
        return refresh
    }()
    
    //MARK: - Life cycle
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindInputs()
        bindOutputs()
        viewModel.searchImages()
    }
    
    //MARK: -
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.outputs.screenTitle
        hideBackButtonTitle()
        view.addSubview(tableView)
        tableView.fillSafeArea()
    }
    
    private func bindOutputs() {
        viewModel
            .outputs
            .stateSubject
            .subscribe(onNext:  { [weak self] state in
                guard let self = self, let state = state else { return }
                state == .loading ? self.startLoading() : self.stopLoading()
                if state != .loading {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .errorSubject
            .subscribe(onNext:  { [weak self] message in
                guard let self = self, let message = message else { return }
                self.alertError(message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .dataSubject
            .bind(to: tableView
                .rx
                .items(cellIdentifier: viewModel.cellIdentifier, cellType: ImageListCell.self)) { (items, object, cell) in
                    cell.image = object
                }
                .disposed(by: disposeBag)
    }
    
    private func bindInputs() {
        tableView
            .rx
            .modelSelected(Image.self)
            .subscribe(onNext:  { [weak self] model in
                self?.showImageDetailsFor(model)
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .willDisplayCell
            .subscribe(onNext:  { [weak self] control in
                self?.viewModel.loadMoreImages(control.indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    
    private func showImageDetailsFor(_ image: Image) {
        let viewModel = ImageDetailsViewModel(image: image)
        let controller = ImageDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func refreshContent(_ sender: AnyObject) {
        viewModel.refreshContent()
    }
    
    
}
