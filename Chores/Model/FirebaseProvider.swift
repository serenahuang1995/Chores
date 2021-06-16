//
//  FirebaseProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseProvider {
    
    static var shared = FirebaseProvider()
    
    lazy var database = Firestore.firestore()
    
    // struct has no reference，為了要修改原本struct的值 必須加inout
    // 這時function丟進來的Chore與原本的Chore是不同reference
    // 用戶新增家事
    func addToDoChore(chore: inout Chore,
                          completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document()
        
        chore.id = docReference.documentID
        
        do {
            
            try docReference.setData(from: chore) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success("add todo chore success"))
                }
            }

        } catch {
            
            completion(.failure(error))
        }
    }
    
    func deleteUnclaimedChore(selectedChore: Chore,
                              completion: @escaping (Result<String, Error>) -> Void) {
        
        let docRefernce = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docRefernce.delete { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("Success"))
            }
        }
    }
    
    // 用戶點選挑戰家事後 會assign owner(也就是自己)進去
    func updateOwner(selectedChore: Chore,
                     completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.owner: UserProvider.shared.user.id]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("update owner success"))
            }
        }
    }
    
    // 用戶完成家事後 點選完成會改變家事的狀態
    func updateStatus(selectedChore: Chore,
                      completion: @escaping (Result<Chore, Error>) -> Void) {
        
        let completedDate = Timestamp.init(date: NSDate() as Date)

        let docRefernce = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docRefernce.updateData([ChoreType.status: 1, ChoreType.completedDate: completedDate]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(selectedChore))
            }
        }
    }
    
    // 監聽家事列表頁面的變動，一開始只會篩選狀態是未完成的
    func fetchChoresListener(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        guard let groupId = UserProvider.shared.user.groupId else { return }
        
        if groupId.isEmpty { return }
        
        let docRefernce = database.collection(Collection.groups).document(groupId)
            .collection(Collection.chores)
            .whereField(ChoreType.status, isEqualTo: 0)
        
        docRefernce.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }
                
                let chores = documents.compactMap({ queryDocument -> Chore? in
                    
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chores))
            }
        }
    }
    
    // 監聽個人家事紀錄的變動，會篩選狀態是已完成、owner是自己的項目
    func fetchUserRecordsListener(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docReference = database.collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores)
            .whereField(ChoreType.status, isEqualTo: 1)
            .whereField(ChoreType.owner, isEqualTo: UserProvider.shared.user.id)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }
                
                let chores = documents.compactMap({ queryDocument -> Chore? in
                    
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chores))
            }
        }
    }
    
    // 獲得目前所有家事種類
    func fetchChoreTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        
        let docReference = database.collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
        
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
        
        let docReference = database.collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
        
        docReference.updateData([GroupType.choreTypes: FieldValue.arrayUnion([choreType])]) { error in
                
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
        
        let docReference = database.collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
        
        docReference
            .updateData([GroupType.choreTypes: FieldValue.arrayRemove([selectedChoreType])]) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(selectedChoreType))
                }
            }
    }
    
    // 用戶自我家事一覽表
    func fetchDifferentChoreType(completion: @escaping (Result<[[Chore]], Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId!)
            .collection(Collection.chores)
            .whereField(ChoreType.owner, isEqualTo: UserProvider.shared.user.id)
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
            
            // 去判斷choresList這邊的二維陣列中 有沒有我目前需要得分堆的家事array
            // 只需要去判斷每一個家事array中的第一個(因為相同的家事會放在一起)
            // firstIndex回傳第一個符合條件的成員在array裡的編號
            let index = choresList.firstIndex { $0[0].item == chore.item }
            
            if let index = index {
                
                // choresList中第幾個array加進家事
                choresList[index].append(chore)
                
            } else {
                
                // 如果家事不存在在choresList中的任何array就會他新增一個新的array
                choresList.append([chore])
            }
        }
        
        return choresList
    }
    
    // 當選擇好轉交的對象與家事之後 會在transfer欄位update那個對象的user id
    func updateTransferUser(user: User, selectedChore: Chore, completion: @escaping (Result<String, Error>) -> Void) {
    
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.transfer: user.id]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("update transfer user Success"))
            }
        }
    }
    
    // 篩選transfer欄位是自己id的家事 這樣可以知道有誰傳送轉交家事給你
    func onTransferListener(userId: String,
                            completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores)
            .whereField(ChoreType.transfer, isEqualTo: UserProvider.shared.user.id)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }

                let chores = documents.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chores))
            }
        }
    }
    
    // 對方接受之後會把transfer清空 owner改寫成對方
    func assignNewChoreOwner(selectedChore: Chore,
                             completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.owner: UserProvider.shared.user.id, ChoreType.transfer: nil]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("assign chore success"))
            }
        }
    }
    
    // 不管用戶是接受還是拒絕 都要清空 transfer 欄位
    func resetTransferOwner(selectedChore: Chore,
                            completion: @escaping (Result<String, Error>) -> Void) {
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores).document(selectedChore.id)
        
        docReference.updateData([ChoreType.transfer: nil ?? ""]) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success("reset transfer success"))
            }
        }
    }

    func fetchWeekData(completion: @escaping (Result<[Chore], Error>) -> Void) {
        
        let date = Date()
        
        let firstDate = date.getFirstDayDateInWeek()
        
        let lastDate = date.getLastDayDateInWeek()
        
        let docReference = database
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores)
            .whereField(ChoreType.completedDate, isGreaterThanOrEqualTo: firstDate)
            .whereField(ChoreType.completedDate, isLessThanOrEqualTo: lastDate)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }

                let chores = documents.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chores))
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
            .collection(Collection.groups).document(UserProvider.shared.user.groupId ?? "")
            .collection(Collection.chores)
            .whereField(ChoreType.completedDate, isGreaterThanOrEqualTo: startDate)
            .whereField(ChoreType.completedDate, isLessThanOrEqualTo: endDate)
        
        docReference.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let documents = querySnapshot?.documents else { return }

                let chores = documents.compactMap({ queryDocument -> Chore? in
                                        
                    return try? queryDocument.data(as: Chore.self)
                })
                
                completion(.success(chores))
            }
        }
    }
    
    // 建立群組後會給該群組一個ID 並且把預設的家事種類加進去
    func createGroup(completion: @escaping (Result<Group, Error>) -> Void) {
        
        let defaultTypes = [
            "洗碗", "洗衣服", "晾衣服", "摺衣服", "燙衣服", "煮飯", "買菜", "掃地", "拖地",
            "吸地", "倒垃圾", "刷廁所", "擦窗戶", "修繕", "澆花", "遛狗", "收納", "接送", "帶小孩"
        ]
        
        let docReference = database.collection(Collection.groups).document()
        
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
}
