//
//  MissionViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit
import Lottie

protocol MissionCellDelegate: AnyObject {
    
    func clickButtonToAccept(at index: Int)
    
    func clickButtonToFinish(at index: Int)
}

class MissionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {

            setUpTableView()
        }
    }

    @IBOutlet weak var lobbyView: UIView!
    
    @IBOutlet weak var lottieView: AnimationView!
    
    // 記錄每個 Section 的狀態，預設false
    var isExpandedList: [Bool] = [false, false]
    
    var allChores: [Chore] = []
    
    var unclaimedChores: [Chore] = []
    
    var ongoingChores: [Chore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetNavigationBarButton()
        
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !lobbyView.isHidden {
            
            lottieView.play()
            
            lottieView.loopMode = .loop
        }
    }
    
    // 用戶每次進來都會 fetch
    func fetchUser() {
        
        let uid = UserProvider.shared.uid
        
        UserProvider.shared.fetchOwner(userId: uid) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                print(user)
                
                self?.setChoresListener()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        _ = segue.destination as? AddChoresViewController
    }
    
    private func resetNavigationBarButton() {
        
        let backButton = UIBarButtonItem(
            image: UIImage.asset(.Icon32px_Plus),
            style: .plain,
            target: self,
            action: #selector(tapAddButton))
        
        self.navigationItem.rightBarButtonItem = backButton
        
    }
    
    @objc func tapAddButton() {
        
        performSegue(withIdentifier: Segue.addChore, sender: nil)
    }
    
    private func setUpTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.registerHeaderWithNib(
            identifier: String(describing: SectionView.self), bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: String(describing: UnclaimedTableViewCell.self), bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: String(describing: OngoingTableViewCell.self), bundle: nil)
        
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    
    func setChoresListener() {
        
        FirebaseProvider.shared.listenChores { [weak self] result in
            
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
                    print("積分 1 倍")
                    multiple = 1
                    
                case 51...100:
                    print("積分 1.2 倍")
                    multiple = 1.2
                    
                case 101...150:
                    print("積分 1.5 倍")
                    multiple = 1.5
                    
                default:
                    print("積分 2 倍")
                    multiple = 2
                    
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
        
        FirebaseProvider.shared.updateUserPoints(user: user) { result in
            
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
        
        if isDisplay {
            
            self.unclaimedChores = self.allChores.filter { $0.owner == nil }
            
            self.ongoingChores = self.allChores.filter { $0.owner != nil }
            
            self.tableView.reloadData()
            
        } else {
            
            lobbyView.isHidden = false
            
            setUpLottie()
        }
    }
    
    func setUpLottie() {
        
        let anination = Animation.named("Chores")
        
        lottieView.animation = anination
        
        lottieView.play()
        
        lottieView.loopMode = .loop
    }
    
}

extension MissionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 300
        }
        
        return 160
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension MissionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: SectionView.self)
        )
        
        guard let sectionView = header as? SectionView else { return header }
        
        sectionView.isExpanded = self.isExpandedList[section]
        
        sectionView.buttonTag = section
        
        sectionView.delegate = self
        
        // 調整section 0 的top constraint 跟 height
        if section == 0 {
            
            sectionView.layoutUnclaimedSection()
        
        } else {
            
            sectionView.layoutOngoingSection()
        }
        
        return sectionView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return isExpandedList.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
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
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        switch indexPath.section {
        
        case 0:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: UnclaimedTableViewCell.self),
                for: indexPath)
            
            guard let unclaimedCell = cell as? UnclaimedTableViewCell else { return cell }
            
            unclaimedCell.delegate = self
            
            unclaimedCell.setUpCellStyle()
            
            unclaimedCell.layoutCell(chore: unclaimedChores[index])
            
            return unclaimedCell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: OngoingTableViewCell.self),
                for: indexPath)
            
            guard let ongoingCell = cell as? OngoingTableViewCell else { return cell }
            
            ongoingCell.delegate = self
            
            ongoingCell.setUpCellStyle()
            
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
    
    func clickButtonToAccept(at index: Int) {
        
        FirebaseProvider.shared.updateOwner(selectedChore: unclaimedChores[index]) { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
            
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func clickButtonToFinish(at index: Int) {
        
        FirebaseProvider.shared.updateStatus(selectedChore: ongoingChores[index]) {
            
            [weak self] result in
            
            switch result {
            
            case .success(let finishedChore):
                
                self?.updatePointsForCompletedChore(chore: finishedChore)
                
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
    
}
