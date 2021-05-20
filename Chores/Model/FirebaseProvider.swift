//
//  FirebaseProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation
import FirebaseFirestore

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
  
  let user = "user"
  
  let chores = "chores"
  
  // struct has no reference，為了要修改原本 struct 的值 必須加inout
  //這時 func 丟進來的 Chores 跟與本的 Chores 是不同 reference
  func addChores(data: inout Chores, completion: @escaping (Result<String, Error>) -> Void) {

    let document = database.collection(groups).document("XW1OPQRPZig550EXPDQG").collection(chores).document()
    data.id = document.documentID
    document.setData(data.dictTransfor) { error in

      if let error = error {

          completion(.failure(error))

      } else {

          completion(.success("Success"))
      }
  }

  }
  
//  func addChores(data: inout Chores) {
//
//    let document = database.collection(chores).document()
//    data.id = document.documentID
//    document.setData(data.dictTransfor)
//
//  }
  
  func readData() {
    
  }
  
  func fetchData() {
    
  }
  
  func listenDataInstantly() {
    
  }
  
}
