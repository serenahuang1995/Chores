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
        
        id: "",
        name: "",
        picture: "",
        points: -1,
        weekHours: -1,
        totalHours: -1,
        groupId: ""
        
    )
    
    // FirebaseUid
    var uid = "XC6b6Ys1VY1qLcBJ5M8z"
//        UserDefaults.standard.string(forKey: "FirebaseUid")
    
//    let userId = UserDefaults.standard.string(forKey: "FirebaseUid")
    
    func addNewUser(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(user.id)
        
        do {
            
            try docReference.setData(from: user) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(FirebaseProvider.shared.success))

                }
            }

        } catch {
            
            completion(.failure(error))
        }
        
    }
    
    // 一次性的fetch user
    func fetchOwner(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let docReference = database.collection(users).document(userId)
        
        docReference.getDocument { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                do {
                    
                    let user = try querySnapshot?.data(as: User.self, decoder: Firestore.Decoder())
                    
                    if let user = user {
                        
                        if user.id == self.uid {
                            
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
    
    func fetchUser(completion: @escaping (Result<User?, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid ?? "")
        
        docReference.getDocument { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                do {
                    
                    let user = try querySnapshot?.data(as: User.self, decoder: Firestore.Decoder())
                    
                    if let user = user {
                        
                        self.user = user
                    }
                    
                    completion(.success(user))
                    
                } catch {
                    
                    completion(.failure(error))
                }
            }
        }
    }
    
    func onFetchUserListener(completion: @escaping (Result<User, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid)
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
    func createGroup(completion: @escaping (Result<Group, Error>) -> Void) {
        
        let defaultTypes = [
            "洗碗", "洗衣服", "晾衣服", "摺衣服", "燙衣服", "煮飯", "買菜", "掃地", "拖地",
            "吸地", "倒垃圾", "刷廁所", "擦窗戶", "修繕", "澆花", "遛狗", "收納", "接送", "帶小孩"
        ]
        
        let docReference = database.collection(groups).document()
        
        let group = Group(id: docReference.documentID, choreTypes: defaultTypes)
        
        do {
            
            try docReference.setData(from: group) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(group))
                }
            }
            
        } catch {
            
            completion(.failure(error))
        }
    }
    
    // 用戶進入群組後 會 assign 該群組的 ID 給使用者
    func updateGroupId(group: Group,
                       completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(user.id)
        
        docReference.updateData([UserType.groupId: group.id]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("Success"))
            }
        }
    }
    
    // 離開群組之後會移除用戶的 group id
    func leaveGroup(completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(user.id)
        
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
