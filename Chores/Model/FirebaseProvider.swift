//
//  FirebaseProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ChoreType {
    
    static var id = "id"
    
    static var status = "status"
    
    static var points = "points"
    
    static var hours = "hours"
    
    static var owner = "owner"
    
}

class FirebaseProvider {
    
    static var shared = FirebaseProvider()
    
    lazy var database = Firestore.firestore()
    
    let groups = "groups"
    
    let users = "users"
    
    let chores = "chores"
    
    let user = UserProvider.shared.user
    
    let success = "Success"
    
    // struct has no reference，為了要修改原本 struct 的值 必須加inout
    // 這時 func 丟進來的 Chores 跟與本的 Chores 是不同 reference
    // 用戶新增家事
    func addToDoChoreData(chore: inout Chore,
                          completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(groups)
            .document(user.groupId!)
            .collection(chores)
            .document()
        
        chore.id = docReference.documentID
        
        do {
            
            try docReference.setData(from: chore) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(self.success))

                }
            }

        } catch {
            
            completion(.failure(error))
        }
    }
    
    // 用戶點選挑戰家事後，會assign owner(也就是自己)進去
    func updateOwner(selectedChore: Chore,
                     completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(groups)
            .document(user.groupId!)
            .collection(chores)
            .document(selectedChore.id)
        
        docReference.updateData([ChoreType.owner: user.id])
        
        completion(.success(success))
    }
    
    // 用戶完成家事後，點選完成會改變家事的狀態
    func updateStatus(selectedChore: Chore,
                      completion: @escaping (Result<Chore, Error>) -> Void) {
        
        let docRefernce = database.collection(groups)
            .document(user.groupId ?? "")
            .collection(chores)
            .document(selectedChore.id)
        
        docRefernce.updateData([ChoreType.status: 1])
        
        completion(.success(selectedChore))
    }
    
    // 監聽家事列表頁面的變動，一開始只會query狀態是未完成的
    func listenChores(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docRefernce = database.collection(groups)
            .document(user.groupId ?? "")
            .collection(chores)
            .whereField(ChoreType.status, isEqualTo: 0)
        
        docRefernce.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }
                
                let choresList = documents.compactMap({ queryDocument -> Chore? in
                    
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(choresList))
            }
        }
    }
    
    // 監聽個人家事紀錄的變動，會 query 狀態是已完成、owner 是自己的項目
    func listenRecords(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docReference = database.collection(groups)
            .document(user.groupId!)
            .collection(chores)
            .whereField(ChoreType.status, isEqualTo: 1)
            .whereField(ChoreType.owner, isEqualTo: user.id)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }
                
                let choresList = documents.compactMap({ queryDocument -> Chore? in
                    
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(choresList))
            }
        }
    }
    
    //  // 一次性的fetch user，完成任務 先 query 用戶的資料，再去改變它的積分與時數
    //  func fetchUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
    //
    //    let docReference = database.collection(users).document(userId)
    //
    //    docReference.getDocument { querySnapshot, error in
    //
    //      if let error = error {
    //
    //        completion(.failure(error))
    //
    //      } else {
    //
    //          do {
    //
    //            let user = try querySnapshot?.data(as: User.self, decoder: Firestore.Decoder())
    //
    //            if let user = user {
    //
    //              completion(.success(user))
    //
    //            }
    //
    //          } catch {
    //
    //            completion(.failure(error))
    //
    //          }
    //
    //      }
    //    }
    //
    //  }
    
    // 獲得目前所有家事種類
    func fetchChoreTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        
        let docReference = database.collection(groups).document(user.groupId ?? "")
        
        docReference.addSnapshotListener {  querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                let group = try? querySnapshot?.data(as: Group.self)
                
                if let group = group {
                    
                    completion(.success(group.choreTypes))
                }
            }
        }
    }
    
    // 給用戶自己新增自訂家事
    func addChoreType(choreType: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(groups).document(user.groupId ?? "")
        
        docReference
            .updateData(["choreTypes": FieldValue.arrayUnion([choreType])]) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(choreType))
                }
            }
    }
    
    // 用戶刪除自訂家事
    func deleteChoreType(selectedChoreType: String,
                         completion: @escaping (Result<String, Error>) -> Void) {

        let docReference = database.collection(groups).document(user.groupId ?? "")
        
        docReference
            .updateData(["choreTypes": FieldValue.arrayRemove([selectedChoreType])]) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(selectedChoreType))
                }
            }
    }
    
    // 更新用戶的點數與時數
    func updateUserPoints(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(user.id)
        
        docReference.updateData([ChoreType.points: user.points,
                                 "totalHours": user.totalHours,
                                 "weekHours": user.weekHours])
        
        completion(.success("Update points success"))
    }
    
    // 用戶自我家事一覽表
    func fetchDifferentChoreType(completion: @escaping (Result<[[Chore]], Error>) -> Void) {
        
        let docReference = database
            .collection(groups)
            .document(user.groupId!)
            .collection(chores)
            .whereField(ChoreType.owner, isEqualTo: user.id)
            .whereField(ChoreType.status, isEqualTo: 1)

        docReference.addSnapshotListener{ querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }
                
                let chores = documents.compactMap({ queryDocument -> Chore? in
                    
                    return try? queryDocument.data(as: Chore.self)
                })
                
                let choresList = self.classifyChoreTypes(chores: chores)
                
                completion(.success(choresList))
            }
        }
    }
    
    func classifyChoreTypes(chores: [Chore]) -> [[Chore]] {
        
        var choresList: [[Chore]] = []
        
        for chore in chores {
            
            print(chore)
            
            let index = choresList.firstIndex { $0[0].item == chore.item }
            
            if let index = index {
                
                choresList[index].append(chore)
                
            } else {
                
                choresList.append([chore])
                
            }
            
        }
        
        return choresList
    }
    
}
