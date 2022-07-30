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
        table.dataSource = self
        table.register(UINib(nibName: viewModel.imageCellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.imageCellIdentifier)
        table.register(UINib(nibName: viewModel.userCellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.userCellIdentifier)
//        table.rowHeight = table.bounds.height * 0.5
//        table.estimatedRowHeight = table
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
//        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.outputs.screenTitle
        view.addSubview(tableView)
        tableView.fillSafeArea()
    }
    
//    private func bindViewModel() {
//        viewModel
//            .image
//            .bind(to: tableView
//                .rx
//                .items(cellIdentifier: viewModel.imageCellIdentifier, cellType: ImageDetailsCell.self)) { (items, object, cell) in
//                    cell.image = object
//                }
//                .disposed(by: disposeBag)
//    }
    
}


extension ImageDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.imageCellIdentifier, for: indexPath) as! ImageDetailsCell
            cell.image = viewModel.image
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.userCellIdentifier, for: indexPath) as! UserDetailsCell
            cell.image = viewModel.image
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.5
    }
    
    
}
