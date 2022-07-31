//
//  LoginViewController.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Properties
    private let viewModel: LoginViewModelType
    private var disposeBag = DisposeBag()
    private let coordinator: AuthenticationCoordinator
    
    //MARK: - Lifecycle
    
    init(viewModel: LoginViewModelType, coordinator: AuthenticationCoordinator) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: -
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
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
        
        viewModel
            .outputs
            .isValidCredentials()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .isValidCredentials()
            .map { $0 ? 1 : 0.2 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        // passed all validation, open home screen
        view.endEditing(true)
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        coordinator.goToHome()
    }
    
    @IBAction func newAccountButtonPressed(_ sender: Any) {
        coordinator.goToRegister()
    }
}
