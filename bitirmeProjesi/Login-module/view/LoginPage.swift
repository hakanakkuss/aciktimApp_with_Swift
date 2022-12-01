//
//  LoginPage.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 24.10.2022.
//

import UIKit
import Firebase

class LoginPage: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var LoginPagePresenterObject : ViewToPresenterLoginPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginPageRouter.createModule(ref: self)
       
    }
    @IBAction func signInButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            self.LoginPagePresenterObject?.login(email: emailText.text!, password: passwordText.text!)
            }

        }

    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}

extension LoginPage : PresenterToViewLoginPageProtocol {
    func viewaVeriGonder(error: String) {
        self.makeAlert(titleInput: "error", messageInput: error)
    }
    
    func gecisYap(){
        self.performSegue(withIdentifier: "toHomePage", sender: nil)
    }
    
    
}


