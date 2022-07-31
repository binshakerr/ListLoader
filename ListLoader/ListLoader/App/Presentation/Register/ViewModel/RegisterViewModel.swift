//
//  RegisterViewModel.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import Foundation
import RxSwift

protocol RegisterViewModelInputs: AnyObject {
    var emailSubject: PublishSubject<String> { get }
    var passwordSubject: PublishSubject<String> { get }
    var ageSubject: PublishSubject<Int> { get }
}

protocol RegisterViewModelOutputs: AnyObject {
    func isValidCredentials() -> Observable<Bool>
    var screenTitle: String { get }
}

protocol RegisterViewModelType: RegisterViewModelInputs, RegisterViewModelOutputs {
    var inputs: RegisterViewModelInputs { get }
    var outputs: RegisterViewModelOutputs { get }
}


class RegisterViewModel: RegisterViewModelType {
    
    var inputs: RegisterViewModelInputs { self }
    var outputs: RegisterViewModelOutputs { self }
    
    var emailSubject = PublishSubject<String>()
    var passwordSubject = PublishSubject<String>()
    var ageSubject = PublishSubject<Int>()
    
    var screenTitle: String {
        return "Register"
    }
    
    func isValidCredentials() -> Observable<Bool> {
        Observable
            .combineLatest(emailSubject.asObservable().startWith(""), passwordSubject.asObservable().startWith(""), ageSubject.asObservable().startWith(1))
            .map { [weak self] (email, password, age) in
                guard let self = self else { return false }
                return self.isValidEmail(email) && self.isValidPassword(password) && self.isValidAge(age)
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
    
    private func isValidAge(_ age: Int) -> Bool {
        return age >= 18 && age <= 99
    }
    
}
