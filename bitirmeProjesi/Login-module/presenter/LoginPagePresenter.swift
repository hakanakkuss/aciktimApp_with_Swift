//
//  LoginPagePresenter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation


class LoginPagePresenter : ViewToPresenterLoginPageProtocol{
    var loginPageView: PresenterToViewLoginPageProtocol?
    var loginPageInteractor: PresenterToInteractorLoginPageProtocol?
    
    
    func login(email: String, password: String) {
        loginPageInteractor?.loginUser(email: email, password: password)
        
    }

}

extension LoginPagePresenter : InteractorToPresenterLoginPageProtocol {
    func presenteraVeriGonder(error: String) {
        loginPageView?.viewaVeriGonder(error: error)
    }
    func successLogin(){
        loginPageView!.gecisYap()
    }
    
    
}
