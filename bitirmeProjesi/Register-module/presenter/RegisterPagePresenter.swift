//
//  RegisterPagePresenter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation

class RegisterPagePresenter : ViewToPresenterRegisterPageProtocol{
    var signUpView: PresenterToViewRegisterPageProtocol?
    var signUpInteractor: PresenterToInteractorRegisterPageProtocol?
    
    func signUp(email: String, password: String) {
        signUpInteractor?.signUpUser(email: email, password: password)
    }
    
    
}

extension RegisterPagePresenter : InteractorToPresenterRegisterPageProtocol {
    func presenteraVeriGonder(error: String) {
            signUpView?.viewaVeriGonder(error: error)
    }
    
    func successRegister() {
        signUpView?.gecisYap()
    }
    
}

