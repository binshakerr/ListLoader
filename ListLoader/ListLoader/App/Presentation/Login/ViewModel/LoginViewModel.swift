//
//  LoginViewModel.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import RxSwift

protocol LoginViewModelInputs: AnyObject {
    var emailSubject: PublishSubject<String> { get }
    var passwordSubject: PublishSubject<String> { get }
}

protocol LoginViewModelOutputs: AnyObject {
    func isValidCredentials() -> Observable<Bool>
}

protocol LoginViewModelType: LoginViewModelInputs, LoginViewModelOutputs {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType {
   
    var inputs: LoginViewModelInputs { self }
    var outputs: LoginViewModelOutputs { self }
    
    var emailSubject = PublishSubject<String>()
    var passwordSubject = PublishSubject<String>()
    
    func isValidCredentials() -> Observable<Bool> {
        Observable
            .combineLatest(emailSubject.asObservable().startWith(""), passwordSubject.asObservable().startWith(""))
            .map { [weak self] (email, password) in
                guard let self = self else { return false }
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .startWith(false)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6 && password.count <= 12
    }

}
