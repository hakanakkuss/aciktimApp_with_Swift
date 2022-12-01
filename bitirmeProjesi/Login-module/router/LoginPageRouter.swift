//
//  LoginPageRouter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation

class LoginPageRouter: PresenterToRouterLoginPageProtocol {
    static func createModule(ref: LoginPage) {
        
        let presenter = LoginPagePresenter()
        ref.LoginPagePresenterObject = presenter

        ref.LoginPagePresenterObject?.loginPageView = ref
        ref.LoginPagePresenterObject?.loginPageInteractor = LoginPageInteractor()

        ref.LoginPagePresenterObject?.loginPageInteractor?.presenterLoginPageView = presenter
            }
     
    }
    
    

