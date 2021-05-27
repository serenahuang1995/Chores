//
//  UserProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserType {
  
  static let id = "id"
  
  static let weekHours = "weekHours"
  
  static let totalHours = "totalHours"
  
  static let points = "points"
  
  static let groupId = "groupId"
}

class UserProvider {

    static let shared = UserProvider()
  
    lazy var database = Firestore.firestore()
  
    let users = "users"
    
    let groups = "groups"

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
    
    let docReference = database.collection(users).document(appleUid)
//      .whereField("id", isEqualTo: appleUid)
    
    docReference.addSnapshotListener {  querySnapshot, error in
      
      if let error = error {
        
        completion(.failure(error))
        
      } else {
        
        let user = try? querySnapshot?.data(as: User.self)
        
        if let user = user {
          
          self.user = user
          
          completion(.success(user))

        }
        
      }
      
    }

  }
  
  // 建立群組後 會給該群組一個 ID
  func createGroup(group: inout Group, completion: @escaping (Result<String, Error>) -> Void) {
    
    let docReference = database.collection(groups).document()
    
    group.id = docReference.documentID
    
    do {
      
      try docReference.setData(from: group) { error in
        
        if let error = error {
          
          completion(.failure(error))
          
        } else {
          
          completion(.success("Success"))
          
        }
        
      }
      
    } catch {
      
      completion(.failure(error))
      
    }

  }
  
  // 用戶進入群組後 會 assign 該群組的 ID 給使用者
  func updateGroupId(sendInvitationGroup: Group,
                     userId: String,
                     completion: @escaping (Result<String, Error>) -> Void) {
    
    let docReference = database.collection(users).document(userId)
    
    docReference.updateData([UserType.groupId: sendInvitationGroup.id]) { error in
      
      if let error = error {
        
        completion(.failure(error))
        
      } else {
        
        completion(.success("Success"))
        
      }
      
    }
    
  }
  
  // 離開群組之後會移除用戶的 group id
  func leaveGroup(userId: String,completion: @escaping (Result<String, Error>) -> Void) {

    let docReference = database.collection(users).document(userId)
    
    docReference.updateData([UserType.groupId: nil,
                             UserType.points: 0,
                             UserType.weekHours: 0,
                             UserType.totalHours: 0]) { error in
      
      if let error = error {
        
        completion(.failure(error))
        
      } else {
        
        completion(.success("Success"))
        
      }
      
    }
    
  }
  

}
