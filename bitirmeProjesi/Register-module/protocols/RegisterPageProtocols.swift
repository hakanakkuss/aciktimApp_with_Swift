//
//  RegisterPageProtocols.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation

protocol ViewToPresenterRegisterPageProtocol {
    var signUpInteractor : PresenterToInteractorRegisterPageProtocol? {get set}
    var signUpView : PresenterToViewRegisterPageProtocol? {get set}
    
    func signUp(email:String,password:String)
}

protocol PresenterToInteractorRegisterPageProtocol {
    var presenterRegisterPageView : InteractorToPresenterRegisterPageProtocol? {get set}
    func signUpUser(email:String,password:String)
}

protocol InteractorToPresenterRegisterPageProtocol {
    func presenteraVeriGonder(error:String)
    func successRegister()
}
protocol PresenterToViewRegisterPageProtocol {
    func viewaVeriGonder(error:String)
    func gecisYap()
}

protocol PresenterToRouterRegisterPageProtocol {
    static func createModule(ref:RegisterPage)
}
