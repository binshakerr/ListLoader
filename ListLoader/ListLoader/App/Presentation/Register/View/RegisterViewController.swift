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
    private let viewModel: RegisterViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    init(viewModel: RegisterViewModel) {
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
    
    //MARK: -
    private func setupUI() {
        navigationItem.title = "Register"
    }

    
    //MARK: - Actions
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
}
