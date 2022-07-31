//
//  RegisterViewController.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: - Properties
    private let viewModel: RegisterViewModelType
    private var disposeBag = DisposeBag()
    private let coordinator: AuthenticationCoordinator
    
    //MARK: - Lifecycle
    init(viewModel: RegisterViewModelType, coordinator: AuthenticationCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
    
    //MARK: -
    private func setupUI() {
        navigationItem.title = viewModel.screenTitle
    }

    func bindViewModel() {
        
        emailTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.inputs.emailSubject)
            .disposed(by: disposeBag)
        
        passwordTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.inputs.passwordSubject)
            .disposed(by: disposeBag)
        
        ageTextField
            .rx
            .text
            .orEmpty
            .map { Int($0) ?? 0 }
            .bind(to: viewModel.inputs.ageSubject)
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .isValidCredentials()
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .isValidCredentials()
            .map { $0 ? 1 : 0.2 }
            .bind(to: registerButton.rx.alpha)
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - Actions
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        // passed all validation, open home screen
        view.endEditing(true)
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        coordinator.goToHome()
    }
}
