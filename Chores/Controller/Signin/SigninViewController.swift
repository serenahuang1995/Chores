//
//  SigninViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/29.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import Lottie

class SigninViewController: UIViewController {

    @IBOutlet weak var privacyButton: UIButton!
    
    @IBOutlet weak var signinView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSigninButton()
        
        setUpLottie()
    }
    
    
    @IBAction func skip(_ sender: Any) {
        
        performSegue(withIdentifier: Segue.initial, sender: nil)
    }
    
    func setUpSigninButton() {
        
        let signinButton = ASAuthorizationAppleIDButton(
            authorizationButtonType: .signIn,
            authorizationButtonStyle: .black)
        
        signinButton.cornerRadius = 10.0
        
        signinButton.addTarget(self, action: #selector(clickAppleSigninButton), for: .touchUpInside)
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(signinButton)
        
        NSLayoutConstraint.activate([
            signinButton.heightAnchor.constraint(equalToConstant: 45),
            signinButton.widthAnchor.constraint(equalToConstant: 280),
            signinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signinButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -20)
        ])

    }
    
    @objc func clickAppleSigninButton() {
        
        let provider = ASAuthorizationAppleIDProvider()
        
        let request = provider.createRequest()
        
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    func setUpLottie() {
        
        let animation = Animation.named("Signin")
        
        signinView.animation = animation
        
        signinView.play()
        
        signinView.loopMode = .loop
    }

}

extension SigninViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        // upload credential to api
        
        print(credential)
    }
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        // Show error
        
        print(error)
    }
}
extension SigninViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
}
