//
//  LoginPageProtocols.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation


protocol ViewToPresenterLoginPageProtocol {
    var loginPageInteractor : PresenterToInteractorLoginPageProtocol? {get set}
    var loginPageView : PresenterToViewLoginPageProtocol? {get set}
    
    func login(email:String,password:String)
}

protocol PresenterToInteractorLoginPageProtocol {
    var presenterLoginPageView : InteractorToPresenterLoginPageProtocol? {get set}
    
    func loginUser(email:String,password:String)
}

//taşıyıcı protocols
protocol InteractorToPresenterLoginPageProtocol {
    func presenteraVeriGonder(error:String)
    func successLogin()
}

protocol PresenterToViewLoginPageProtocol {
    func viewaVeriGonder(error:String)
    func gecisYap()
}

protocol PresenterToRouterLoginPageProtocol {
    static func createModule(ref:LoginPage)
}
