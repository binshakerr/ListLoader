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
    
    //MARK: - Lifecycle
    
    init(viewModel: LoginViewModelType) {
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
    
    private func goToRegister() {
        let viewModel = RegisterViewModel()
        let controller = RegisterViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func goToHome() {
        let repository = ImageRepository(networkManager: NetworkManager.shared)
        let viewModel = HomeViewModel(imageRepository: repository)
        let controller = HomeViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        sceneDelegate?.window?.rootViewController = navigation
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        // passed all validation, open home screen
        view.endEditing(true)
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        goToHome()
    }
    
    @IBAction func newAccountButtonPressed(_ sender: Any) {
        goToRegister()
    }
}
