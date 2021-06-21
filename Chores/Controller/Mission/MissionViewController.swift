//
//  MissionViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit
import Lottie
import UserNotifications

protocol MissionCellDelegate: AnyObject {
    
    func onButtonAccept(at index: Int)
    
    func onButtonDelete(at index: Int)

    func onButtonFinish(at index: Int)
    
    func onButtonTransfer(at index: Int)
}

class MissionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {

            setUpTableView()
        }
    }

    @IBOutlet weak var lobbyView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    // 記錄每個 Section 的狀態，預設false
    var isExpandedList: [Bool] = [false, false]
    
    var allChores: [Chore] = []
    
    var unclaimedChores: [Chore] = []
    
    var ongoingChores: [Chore] = []
    
    var transferChores: [Chore] = []

    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetNavigationBarButton()
    
        fetchUser()
        
        NotificationUtils().setChoresReminder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !lobbyView.isHidden {
            
            animationView.play()
            
            animationView.loopMode = .loop
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        case Segue.addChore:
            
            _ = segue.destination as? AddChoresViewController
            
        case Segue.transfer:
            
            guard let destination = segue.destination as? TransferChoreViewController else { return }
            
            if let selectedIndex = selectedIndex {
                
                destination.transferChore = ongoingChores[selectedIndex]
            }
            
        case Segue.dialog:
            
            guard let destination = segue.destination as? TransferDialogViewController else { return }
            
            destination.chore = transferChores[0]
            
        default:
            
            return
        }
    }
    
    private func resetNavigationBarButton() {
        
        let backButton = UIBarButtonItem(
            image: UIImage.asset(.Icon24px_Plus),
            style: .plain,
            target: self,
            action: #selector(tapAddButton))
        
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    @objc func tapAddButton() {
        
        performSegue(withIdentifier: Segue.addChore, sender: nil)
    }
    
    private func setUpTableView() {
        
        tableView.registerHeaderWithNib(
            identifier: String(describing: SectionView.self), bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: String(describing: UnclaimedTableViewCell.self), bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: String(describing: OngoingTableViewCell.self), bundle: nil)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    // 用戶每次進來都會 fetch
    func fetchUser() {

        UserProvider.shared.fetchOwner(userId: UserProvider.shared.uid ?? "") { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                print(user)
                
                self?.fetchGroupMembers()
                
                self?.setChoresListener()

                self?.onTransferListener()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func setChoresListener() {
        
        FirebaseProvider.shared.fetchChoresListener { [weak self] result in
            
            switch result {
            
            case .success(let chores):
                
                self?.allChores = chores
                
                self?.displayData(isDisplay: chores.count != 0)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    // 先確認用戶的資料，再去改變它的積分與時數，還有積分加權的處理
    func updatePointsForCompletedChore(chore: Chore) {
        
        guard let userId = chore.owner else { return }
        
        UserProvider.shared.fetchOwner(userId: userId) { [weak self] result in
            
            switch result {
            
            case .success(var user):
                
                print(user)
                
                var multiple = 1.0
                
                switch user.weekHours {
                
                case 0...50:

                    multiple = 1 // 積分 1 倍
                    
                case 51...100:

                    multiple = 1.2 // 積分 1.2 倍
                    
                case 101...150:

                    multiple = 1.5 // 積分 1.5 倍
                    
                default:

                    multiple = 2 // 積分 2 倍
                }
                
                user.weekHours += chore.hours
                
                user.totalHours += chore.hours
                
                user.points += Int(Double(chore.points) * multiple)
                
                self?.updatePoints(user: user)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func updatePoints(user: User) {
        
        UserProvider.shared.updateUserPoints(user: user) { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
            case .failure(let error):
                
                print(error)                
            }
        }
    }
    
    func displayData(isDisplay: Bool) {
        
        tableView.isHidden = !isDisplay
        
        lobbyView.isHidden = isDisplay

        if isDisplay {
            
            self.unclaimedChores = self.allChores.filter { $0.owner == nil }
            
            self.ongoingChores = self.allChores.filter { $0.owner != nil }
            
            self.tableView.reloadData()
            
        } else {
            
            lobbyView.isHidden = false
            
            animationView.configureLottieView(name: Lottie.washing)
        }
    }
    
    func onTransferListener() {

        FirebaseProvider.shared.onTransferListener(userId: UserProvider.shared.uid ?? "") { [weak self] result in
            
            switch result {
            
            case .success(let chores):
                
                print(chores)
                
                self?.transferChores = chores
                
                if chores.count > 0 {
                    
                    self?.performSegue(withIdentifier: Segue.dialog, sender: nil)
                }

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func fetchGroupMembers() {
        
        UserProvider.shared.fetchGroupMember { result in

            switch result {
            
            case .success(let users):
                
                print("group member: \(users)")
           
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension MissionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        // 判斷section如果為0 就是true 會跑210
        return section == 0 ? 210 : 160
        
//        if section == 0 {
//
//            return 210 //300
//        }
//
//        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}

extension MissionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: SectionView.self)
        )
        
        guard let sectionView = header as? SectionView else { return header }
        
        sectionView.isExpanded = self.isExpandedList[section]
        
        sectionView.buttonTag = section
        
        sectionView.delegate = self
        
        if section == 0 {
            
            sectionView.layoutSection(section: .unclaimed)
            
            sectionView.setExpandButtonVisible(isVisible: unclaimedChores.count != 0)
        
        } else {
            
            sectionView.layoutSection(section: .ongoing)
            
            sectionView.setExpandButtonVisible(isVisible: ongoingChores.count != 0)
        }

        return sectionView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return isExpandedList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // true 的時候會依照不同 Section 去抓要顯示幾個 Row
        if self.isExpandedList[section] {
            
            if section == 0 {
                
                return unclaimedChores.count
                
            } else {
                
                return ongoingChores.count
            }
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        switch indexPath.section {
        
        case 0:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: UnclaimedTableViewCell.self),
                for: indexPath)
            
            guard let unclaimedCell = cell as? UnclaimedTableViewCell else { return cell }
            
            unclaimedCell.delegate = self

            unclaimedCell.layoutCell(chore: unclaimedChores[index])
            
            return unclaimedCell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: OngoingTableViewCell.self),
                for: indexPath)
            
            guard let ongoingCell = cell as? OngoingTableViewCell else { return cell }
            
            ongoingCell.delegate = self

            ongoingCell.layoutCell(chore: ongoingChores[index])
            
            return ongoingCell
            
        default:
            
            return UITableViewCell()
        }
    }
}

extension MissionViewController: SectionViewDelegate {
    
    func showMoreItem(_ section: SectionView, _ didPressTag: Int, _ isExpanded: Bool) {
        
        isExpandedList[didPressTag] = !isExpanded
        
        tableView.reloadSections(IndexSet(integer: didPressTag), with: .automatic)
    }
}

extension MissionViewController: MissionCellDelegate {
            
    func onButtonAccept(at index: Int) {
        
        FirebaseProvider.shared.updateOwner(selectedChore: unclaimedChores[index]) { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
            
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func onButtonDelete(at index: Int) {
        
        FirebaseProvider.shared.deleteUnclaimedChore(selectedChore: unclaimedChores[index]) { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func onButtonFinish(at index: Int) {
        
        FirebaseProvider.shared.updateStatus(selectedChore: ongoingChores[index]) { [weak self] result in
            
            switch result {
            
            case .success(let finishedChore):
                
                self?.updatePointsForCompletedChore(chore: finishedChore)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func onButtonTransfer(at index: Int) {
        
        selectedIndex = index
        
        performSegue(withIdentifier: Segue.transfer, sender: nil)
    }
}


