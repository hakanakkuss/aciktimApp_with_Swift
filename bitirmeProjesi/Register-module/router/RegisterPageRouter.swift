//
//  RegisterPageRouter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation

class RegisterPageRouter: PresenterToRouterRegisterPageProtocol {
    static func createModule(ref: RegisterPage) {
        
        let presenter = RegisterPagePresenter()
        ref.registerPresenterObject = presenter

        ref.registerPresenterObject?.signUpView = ref
        ref.registerPresenterObject?.signUpInteractor = RegisterPageInteractor()

        ref.registerPresenterObject?.signUpInteractor?.presenterRegisterPageView = presenter
    }
    
    
}
