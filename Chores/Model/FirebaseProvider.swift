//
//  FirebaseProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum FirebaseError: Error {
    case firebaseError
}

enum FirebaseReference {
    
    case collection(CollectionReference)
    
    case document(DocumentReference)
}

class FirebaseProvider {
  
  static var shared = FirebaseProvider()
  
  lazy var database = Firestore.firestore()
  
  let groups = "groups"
  
  let users = "users"
  
  let chores = "chores"
  
  // struct has no reference，為了要修改原本 struct 的值 必須加inout
  // 這時 func 丟進來的 Chores 跟與本的 Chores 是不同 reference
  func addToDoChoreData(data: inout Chores, completion: @escaping (Result<String, Error>) -> Void) {

    let document = database.collection(groups).document("XW1OPQRPZig550EXPDQG").collection(chores).document()
    
    data.id = document.documentID
    
    do {
      
      try document.setData(from: data) { error in
        
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
  
  func fetchChoresData(completion: @escaping (Result<[Chores], Error>) -> Void) {
    
    let docRefernce = database.collection(groups).document("XW1OPQRPZig550EXPDQG").collection(chores)
      
    docRefernce.getDocuments() { querySnapshot, error in
          
              if let error = error {
                  
                  completion(.failure(error))
                
              } else {
                  
                  var chores = [Chores]()
                  
                  for document in querySnapshot!.documents {

                      do {
                          if let chore = try document.data(as: Chores.self, decoder: Firestore.Decoder()) {
                            chores.append(chore)
                          }
                          
                      } catch {
                          
                          completion(.failure(error))

                      }
                  }
                  
                  completion(.success(chores))
              }
      }
  }
  
  func listenDataInstantly() {
    
  }
  
  func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
    
    let docRefernce = database.collection(users)
      
    docRefernce.getDocuments() { querySnapshot, error in
          
              if let error = error {
                  
                  completion(.failure(error))
                
              } else {
                  
                  
                  for document in querySnapshot!.documents {

                      do {
                        
                        let user = try document.data(as: User.self, decoder: Firestore.Decoder())
                        
                        if let user = user {
      
                          completion(.success(user))

                        }
                          
                      } catch {
                          
                          completion(.failure(error))

                      }
                  }
                  
              }
      }
  }
  
}
