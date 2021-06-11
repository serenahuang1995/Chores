//
//  ProfileViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    
    func backToProfile()
}

class ProfileViewController: UIViewController {
    
    private enum PageType: Int {
        
        case records = 0
        
        case data = 1        
    }
    
    @IBOutlet weak var userImage: UIImageView! {
        
        didSet {
            
            userImage.layer.cornerRadius = userImage.frame.height / 2
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    @IBOutlet weak var weekHoursLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIView! {
        
        didSet {
            
            indicatorView.backgroundColor = .orangeFCA311
        }
    }
    
    @IBOutlet weak var dataContainerView: UIView!
    
    @IBOutlet weak var recordsContainerView: UIView!
    
    @IBOutlet var switchButtons: [UIButton]!
    
    var containerViews: [UIView] {
        
        return [recordsContainerView, dataContainerView]
    }
    
    var imageUpdateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContainerView(type: .records)
        
        setUpUserListener()
        
        confirmWeekday()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        
        indicatorView.center.x = switchButtons[0].center.x
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identifier = segue.identifier
        
        switch identifier {
        
        case Segue.records:
            
            _ = segue.destination as? ChoresRecordsViewController
            
        case Segue.data:
            
            _ = segue.destination as? ChoresDataViewController
            
        case Segue.setting:
            
            let destination = segue.destination as? SettingViewController
            
            destination?.delegate = self
        
        default:
            
            return
        }
    }
    
    @IBAction func clickSwitchButton(_ sender: UIButton) {
        
        for btn in switchButtons {
            
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        moveIndicatorView(sender: sender)
        
        guard let type = PageType(rawValue: sender.tag) else { return }
        
        updateContainerView(type: type)
    }
    
    private func moveIndicatorView(sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.indicatorView.center.x = self.switchButtons[sender.tag].center.x
        }
    }
    
    private func updateContainerView(type: PageType) {
        
        containerViews.forEach({ $0.isHidden = true })
        
        switch type {
        
        case .records:
            recordsContainerView.isHidden = false
            
        case .data:
            dataContainerView.isHidden = false
        }
    }
    
    func setUpUserListener() {
        
        UserProvider.shared.onFetchUserListener { result in
            
            switch result {
            
            case .success(let user):
                
                if self.imageUpdateCount <= 0 {
                    
                    self.userImage.loadImage(user.picture)
                    
                } else {
                    
                    self.imageUpdateCount -= 1
                }
                
//                self.userImage.kf.setImage(with: URL(string: user.picture))
                
//
//                self.userImage.loadImage(user.picture, placeHolder: UIImage(named: user.picture))

                self.userNameLabel.text = user.name
                
                self.totalPointsLabel.text = "累積點數：\(user.points)"
                
                self.weekHoursLabel.text = "本週時數：\(user.weekHours) / 50"
                
            case .failure(let error):
                
                print(error)
            }
        }
    }

    func confirmWeekday() {
        
        let date = Date()
        
        let weekDay = date.currentWeekDay()

        if weekDay == "Monday" {

            resetWeekHours()
        }
    }
    
    func resetWeekHours() {
        
        FirebaseProvider.shared.updateWeekHours { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
//    func changeUserImage(userImage: UIImageView) {
//        
//        StorageProvider.shared.downloadImage(userImage: userImage)
//    }
}

extension ProfileViewController: SettingDelegate {
    
    func onImageUploaded(image: UIImage) {

        userImage.image = image
        
        imageUpdateCount += 1
    }
}
