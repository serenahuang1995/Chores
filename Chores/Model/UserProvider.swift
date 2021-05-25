//
//  UserProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserProvider {

    static let shared = UserProvider()
  
    lazy var database = Firestore.firestore()
  
    let users = "users"

    var user: User = User(
      
      id: "XC6b6Ys1VY1qLcBJ5M8z",
      name: "Serena",
      picture: "",
      points: 66666666666,
      weekHours: 666,
      totalHours: 66666666666,
      groupId: "XW1OPQRPZig550EXPDQG"
      
    )
  
  var appleUid = "XC6b6Ys1VY1qLcBJ5M8z"
  
  // 一次性的fetch user
  func fetchUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
    
    let docReference = database.collection(users).document(userId)
    
    docReference.getDocument { querySnapshot, error in
      
      if let error = error {
        
        completion(.failure(error))
        
      } else {
          
          do {
            
            let user = try querySnapshot?.data(as: User.self, decoder: Firestore.Decoder())
            
            if let user = user {
              
              if user.id == self.appleUid {
                
                self.user = user
                
              }
              
              completion(.success(user))
              
            }
            
          } catch {
            
            completion(.failure(error))
            
          }

      }
    }
  
  }
  
  
  func onFetchUserListener(completion: @escaping (Result<User, Error>) -> Void) {
    
    let docReference = database
      .collection(users).document(appleUid)
//      .whereField("id", isEqualTo: appleUid)
    
    docReference.addSnapshotListener {  querySnapshot, error in
      
      if let error = error {
        
        completion(.failure(error))
        
      } else {
        
        let user = try? querySnapshot?.data(as: User.self)
        
        if let user = user {
          
          completion(.success(user))

        }
        
      }
      
    }
    
    
    
    
  }
  
  
  
  
    
}
