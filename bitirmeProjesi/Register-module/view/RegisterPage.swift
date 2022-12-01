//
//  RegisterPage.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import UIKit
import Firebase

class RegisterPage: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var registerPresenterObject: ViewToPresenterRegisterPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RegisterPageRouter.createModule(ref: self)
    }

    @IBAction func signUpButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            self.registerPresenterObject?.signUp(email: emailText.text!, password: passwordText.text!)
            }
        }
        
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}


extension RegisterPage : PresenterToViewRegisterPageProtocol {
    func viewaVeriGonder(error: String) {
        self.makeAlert(titleInput: "error", messageInput: error)
    }
    
    func gecisYap() {
        self.performSegue(withIdentifier: "toHomePage", sender: nil)
    }
    
    
}
