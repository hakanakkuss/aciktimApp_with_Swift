//
//  RegisterPageInteractor.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import Foundation
import Firebase

class RegisterPageInteractor : PresenterToInteractorRegisterPageProtocol {
    var presenterRegisterPageView: InteractorToPresenterRegisterPageProtocol?
    
    func signUpUser(email: String, password: String) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { AuthDataResult, error in
            if error != nil {
                self.presenterRegisterPageView?.presenteraVeriGonder(error: error!.localizedDescription)
            }
            else {
                self.presenterRegisterPageView?.successRegister()
            }
        }
    }
    
    
}
    


