//
//  LoginPageInteractor.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation
import Firebase

class LoginPageInteractor: PresenterToInteractorLoginPageProtocol {
    var presenterLoginPageView: InteractorToPresenterLoginPageProtocol?
        
    func loginUser(email: String, password: String) {
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { authResult, error in
        if error != nil {
            self.presenterLoginPageView?.presenteraVeriGonder(error: error!.localizedDescription)
           
        }else {
            self.presenterLoginPageView?.successLogin()
        }
        }
        
        
    }
    
    
    
}
