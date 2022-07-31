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
    private let viewModel: LoginViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    private func goToRegister() {
        let viewModel = RegisterViewModel()
        let controller = RegisterViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    

    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func newAccountButtonPressed(_ sender: Any) {
        goToRegister()
    }
}
