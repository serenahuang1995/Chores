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
    
    static var transfer = "transfer"
    
    static var completedDate = "completedDate"
}

struct GroupType {
    
    static var id = "id"
    
    static var choreTypes = "choreTypes"
}

class FirebaseProvider {
    
    static var shared = FirebaseProvider()
    
    lazy var database = Firestore.firestore()
    
    let groups = "groups"
    
    let users = "users"
    
    let chores = "chores"
    
    let currentUser = UserProvider.shared.user
    
    let success = "Success"
    
    // struct has no reference，為了要修改原本 struct 的值 必須加inout
    // 這時 func 丟進來的 Chores 跟與本的 Chores 是不同 reference
    // 用戶新增家事
    func addToDoChoreData(chore: inout Chore,
                          completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(groups)
            .document(currentUser.groupId!)
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
            .document(currentUser.groupId!)
            .collection(chores)
            .document(selectedChore.id)
        
        docReference.updateData([ChoreType.owner: currentUser.id])
        
        completion(.success(success))
    }
    
    // 用戶完成家事後，點選完成會改變家事的狀態
    func updateStatus(selectedChore: Chore,
                      completion: @escaping (Result<Chore, Error>) -> Void) {
        
        let addDataTime = Timestamp.init(date: NSDate() as Date)

        let docRefernce = database.collection(groups)
            .document(currentUser.groupId ?? "")
            .collection(chores)
            .document(selectedChore.id)
        
        docRefernce.updateData([ChoreType.status: 1, ChoreType.completedDate: addDataTime])
        
        completion(.success(selectedChore))
    }
    
    // 監聽家事列表頁面的變動，一開始只會query狀態是未完成的
    func listenChores(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docRefernce = database.collection(groups)
            .document(currentUser.groupId!)
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
            .document(currentUser.groupId!)
            .collection(chores)
            .whereField(ChoreType.status, isEqualTo: 1)
            .whereField(ChoreType.owner, isEqualTo: currentUser.id)
        
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
    
    // 獲得目前所有家事種類
    func fetchChoreTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        
        let docReference = database.collection(groups).document(currentUser.groupId ?? "")
        
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
    func addChoreType(choreType: String,
                      completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(groups).document(currentUser.groupId ?? "")
        
        docReference
            .updateData([GroupType.choreTypes: FieldValue.arrayUnion([choreType])]) { error in
                
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

        let docReference = database.collection(groups).document(currentUser.groupId ?? "")
        
        docReference
            .updateData([GroupType.choreTypes: FieldValue.arrayRemove([selectedChoreType])]) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(selectedChoreType))
                }
            }
    }
    
    // 更新用戶的點數與時數，因為有可能會是別人幫你按完成，但點數要更新在自己身上，所以parameter會帶一個 user
    func updateUserPoints(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(user.id)
        
        docReference.updateData([UserType.points: user.points,
                                 UserType.totalHours: user.totalHours,
                                 UserType.weekHours: user.weekHours]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("Update points success"))
            }
        }
    }
    
    // 用戶自我家事一覽表
    func fetchDifferentChoreType(completion: @escaping (Result<[[Chore]], Error>) -> Void) {
        
        let docReference = database
            .collection(groups)
            .document(currentUser.groupId!)
            .collection(chores)
            .whereField(ChoreType.owner, isEqualTo: currentUser.id)
            .whereField(ChoreType.status, isEqualTo: 1)

        docReference.addSnapshotListener { querySnapshot, error in
            
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
    
    // 家事分類 將相同的家事分堆
    func classifyChoreTypes(chores: [Chore]) -> [[Chore]] {
        
        var choresList: [[Chore]] = []
        
        for chore in chores {
            
            print(chore)
            
            // 去判斷 choresList 這邊的二維陣列中 有沒有我目前需要得分堆的家事 array
            // 只需要去判斷每一個家事 array中的第一個(因為相同的家事會放在一起)
            // firstIndex回傳第一個符合條件的成員在 array 裡的編號
            let index = choresList.firstIndex { $0[0].item == chore.item }
            
            if let index = index {
                
                // choresList中第幾個 array 加進家事
                choresList[index].append(chore)
                
            } else {
                
                // 如果家事不存在在 choresList 中的任何 array 就會他新增一個新的 array
                choresList.append([chore])
            }
        }
        
        return choresList
    }

    // 目前是自己登入以後會更新自己的每週時數
    func updateWeekHours(completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database.collection(users).document(UserProvider.shared.uid)
        
        docReference.updateData([UserType.weekHours: 0])
        
        completion(.success("Update weekHours success"))
    }
    
    // 當選擇好轉交的對象與家事之後 會在 transfer 欄位 update 那個對象的 user id
    func updateTransferUser(user: User, selectedChore: Chore, completion: @escaping (Result<String, Error>) -> Void) {
    
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "")
            .collection(chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.transfer: user.id]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(self.success))
            }
        }
    }
    
    // query transfer 欄位是自己 id 的家事 這樣可以知道有誰傳送轉交家事給你
    func listenTransfer(userId: String,
                        completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "")
            .collection(chores).whereField(ChoreType.transfer, isEqualTo: currentUser.id)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let choreList = querySnapshot?.documents else { return }

                let chore = choreList.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chore))
            }
        }
    }
    
    // 對方接受之後會把 transfer 清空 owner 改寫成自己
    func assignNewChoreOwner(selectedChore: Chore,
                             completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "")
            .collection(chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.owner: currentUser.id,
                                 ChoreType.transfer: nil]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(self.success))
            }
        }
    }
    
    // 不管用戶是接受還是拒絕 都要清空 transfer 欄位
    func resetTransferOwner(selectedChore: Chore,
                            completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "")
            .collection(chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.transfer: nil ?? ""]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(self.success))
            }
        }
    }

    func fetchWeekData(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let date = Date()
        
        let firstDate = date.getFirstDayDateInWeek()
        
        let lastDate = date.getLastDayDateInWeek()
        
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "").collection(chores)
            .whereField(ChoreType.completedDate, isGreaterThanOrEqualTo: firstDate)
            .whereField(ChoreType.completedDate, isLessThanOrEqualTo: lastDate)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let choreList = querySnapshot?.documents else { return }

                let chore = choreList.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chore))
            }
        }
    }
    
    func fetchMonthData(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"

        // 當月第一天 00:00:00
        let startDate = date.startOfCurrentMonth()

        // 當月最後一天 23:59:59
        let endDate = date.endOfCurrentMonth(returnDetailTime: true)
        
        let docReference = database
            .collection(groups).document(currentUser.groupId ?? "").collection(chores)
            .whereField(ChoreType.completedDate, isGreaterThanOrEqualTo: startDate)
            .whereField(ChoreType.completedDate, isLessThanOrEqualTo: endDate)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let choreList = querySnapshot?.documents else { return }

                let chore = choreList.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chore))
            }
        }
    }
}
