//
//  String + Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/18.
//

import UIKit

extension String {
    
    static func randomNonce(length: Int = 32) -> String {
        
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
}
