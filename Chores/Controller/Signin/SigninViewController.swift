//
//  SigninViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/29.
//

import UIKit
import AuthenticationServices

class SigninViewController: UIViewController {

    @IBOutlet weak var privacyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSigninButton()
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

}

extension SigninViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        // upload credential to api
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Show error
    }
}
extension SigninViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
}
