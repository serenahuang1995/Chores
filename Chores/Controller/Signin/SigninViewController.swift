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
import CryptoKit

class SigninViewController: UIViewController {

    @IBOutlet weak var privacyButton: UIButton!
    
    @IBOutlet weak var signinView: AnimationView!
    
    fileprivate var currentNonce: String?
    
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

    @available(iOS 13, *)
    @objc func clickAppleSigninButton() {
        
        let provider = ASAuthorizationAppleIDProvider()
        
        let request = provider.createRequest()
        
        request.requestedScopes = [.email, .fullName]
        
        let nonce = randomNonceString()
        
        currentNonce = nonce
        
        request.nonce = sha256(nonce)
        
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
    
    func fetchUser() {
        
        UserProvider.shared.fetchUser(userId: <#T##String#>) { result in
            
            
            
        }
        
        
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}

@available(iOS 13.0, *)
extension SigninViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        //        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        // upload credential to api
        
        //        print(credential)
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if let error = error {

                    print(error.localizedDescription)
                    
                    return
                    
                } else {
                    
                    print(authResult!.user)
                    
                    guard let user = authResult?.user else { return }
                    
                    print(user.email as Any)
                    
                    print(user.displayName as Any)
                    
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    
                    print(uid)
                    
                    let userDefault = UserDefaults()
                        
                    userDefault.setValue(uid, forKey: "FirebaseUid")
                }
            }
        }
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
