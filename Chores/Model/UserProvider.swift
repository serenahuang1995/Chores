//
//  UserProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum UserFetchError: Error {
    
    case userNotExist
    
    case firebaseError(error: Error)
}

struct UserType {
    
    static let id = "id"
    
    static let weekHours = "weekHours"
    
    static let totalHours = "totalHours"
    
    static let points = "points"
    
    static let groupId = "groupId"
    
    static let name = "name"
}

class UserProvider {
    
    static let shared = UserProvider()
    
    lazy var database = Firestore.firestore()
    
    let users = "users"
    
    let groups = "groups"
    
    let invitations = "invitations"
    
    var user: User = User(
        
        id: "",
        name: "",
        picture: "",
        points: -1,
        weekHours: -1,
        totalHours: -1,
        groupId: ""
        
    )
    
    var groupMembers: [User] = []
    
    // FirebaseUid
    var uid: String? =
//        "ARNaS8WOtYviuzarS5nb" // Ainee被邀請
//        "XC6b6Ys1VY1qLcBJ5M8z"  // Serena mock data
//    "N8VeGRV8Ev9CHvGPp7Bd" // Max
//    "29cTFrYztvTPK8IHoA1m" // 沛沛
//    "DOy8GQ6CRh5qeHnodC2y"  // 派派
//    "E7YYDXzzUAFus39YhKoR" // James
//    "QlO66m51RGdoSMJv95FT" // Wayne
//    "UedNXmGiiB2vhf2Njm8g" // Surbine
//    "dacURDVFPNY4SIdW4w3S" // Hannah
//    "dc7CXgn8G5kCX7h6rEPR" // Ben
//    "vTphjWhWRffOaEXgqOrQ" //Wen

        UserDefaults.standard.string(forKey: "FirebaseUid")

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
    func fetchOwner(userId: String, completion: @escaping (Result<User, UserFetchError>) -> Void) {
        
        let docReference = database.collection(users).document(userId)
        
        docReference.getDocument { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(UserFetchError.firebaseError(error: error)))
                
            } else {
                
                do {
                    
                    let user = try querySnapshot?.data(as: User.self, decoder: Firestore.Decoder())
                    
                    if let user = user {
                        
                        if user.id == self.uid {
                            
                            self.user = user
                        }
                        
                        completion(.success(user))
                        
                    } else {
                        
                        completion(.failure(UserFetchError.userNotExist))
                    }
                    
                } catch {
                    
                    completion(.failure(UserFetchError.firebaseError(error: error)))
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
    
    // Profile在用的
    func onFetchUserListener(completion: @escaping (Result<User, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid ?? "")
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
    
    func updateGroupId(groupId: String,
                       completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid ?? "")
        
        docReference.updateData([UserType.groupId: groupId]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("Success"))
            }
        }
    }
    
    // 用戶進入群組後 會 assign 該群組的 ID 給使用者
    func updateGroupId(invitation: Invitation,
                       completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid ?? "")
        
        docReference.updateData([UserType.groupId: invitation.group]) { error in
            
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
        
        docReference.updateData([UserType.groupId: nil ?? "",
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
    
    func sendInviation(invitation: Invitation,
                       userId: String,
                       completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users)
            .document(userId)
            .collection(invitations)
            .document()
        
        // 用 documentId 當作 invitation id
        let documentId = docReference.documentID
        
        var newInvitation = invitation
        
        newInvitation.id = documentId
        
        do {
            
            try docReference.setData(from: newInvitation) { error in
                
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
    
    func listenInvitation(completion: @escaping (Result<[Invitation], Error>) -> Void) {
        
        let docReference = database.collection(users)
            .document(uid ?? "")
            .collection(invitations)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let invitations = querySnapshot?.documents else { return }
                
                let invitation = invitations.compactMap({ queryDocument -> Invitation? in
                    
                    return try? queryDocument.data(as: Invitation.self)
                })
                
                completion(.success(invitation))
            }
        }
    }
    
    func deleteInvitation(invitation: Invitation,
                          completion: @escaping (Result<String, Error>) -> Void) {
        
        let docRerence = database
            .collection(users).document(uid ?? "")
            .collection(invitations).document(invitation.id)
        
        docRerence.delete() { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("Success"))
            }
        }
    }

    func fetchGroupMember(completion: @escaping (Result<[User], Error>) -> Void) {
        
        let docRerence = database
            .collection(users)
            .whereField(UserType.groupId, isEqualTo: user.groupId ?? "")
        
        docRerence.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let users = querySnapshot?.documents else { return }

                let groupUsers = users.compactMap({ queryDocument -> User? in
                                        
                    return try? queryDocument.data(as: User.self)
                })
                
                self.groupMembers = groupUsers
                
                completion(.success(groupUsers))
            }
        }
    }
    
    // 判斷我帶進來的任一 id 有沒有符合 group members 內的 user id，找到那個user並回傳他 user 的 name
    func getUserNameById(id: String) -> String? {
        
        // 利用 firstIndex 去找 groupMembers 這個 array 中第幾個 index 是符合條件的
        let index = groupMembers.firstIndex { $0.id == id }

        if let index = index {
            
            return groupMembers[index].name

        } else {

            return nil
        }
        
//        var foundUser: User?
//
//        for user in groupMembers {
//
//            if id == user.id {
//
//                foundUser = user
//
//                break
//            }
//        }
//
//        return foundUser?.name
    }
    
    func changeUserName(name: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(uid ?? "")
        
        docReference.updateData([UserType.name: name]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(FirebaseProvider.shared.success))
            }
        }
    }
}
