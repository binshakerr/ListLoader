//
//  ImageDetailsViewController.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ImageDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: ImageDetailsViewModelProtocol
    private let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.register(UINib(nibName: viewModel.imageCellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.imageCellIdentifier)
        table.register(UINib(nibName: viewModel.userCellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.userCellIdentifier)
        return table
    }()
    
    //MARK: - Life cycle
    init(viewModel: ImageDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.outputs.screenTitle
        view.addSubview(tableView)
        tableView.fillSafeArea()
    }
    
    private func bindViewModel() {
        viewModel
            .outputs
            .items
            .bind(to: tableView.rx.items(dataSource: viewModel.outputs.dataSource))
            .disposed(by: disposeBag)
    }
    
}


extension ImageDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.bounds.height * 0.6
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
