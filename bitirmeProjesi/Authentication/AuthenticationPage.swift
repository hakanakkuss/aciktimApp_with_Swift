//
//  OnboardingPage.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 19.10.2022.
//

import UIKit
import Lottie

class AuthenticationPage: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "59677-fast-food")
        animationView!.frame = view.bounds
        animationView.frame = CGRect(x: 0, y: 238, width: 420, height: 400)
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
    }

    @IBAction func startButton(_ sender: Any) {
        performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
    @IBAction func registerButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterPage", sender: nil)
    }
    
}
