//
//  ProfileViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit
import Lottie

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
    
    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet var switchButtons: [UIButton]!
    
    weak var delegate: SettingDelegate?
    
    let blackView = UIView(frame: UIScreen.main.bounds)
    
    var containerViews: [UIView] {
        
        return [recordsContainerView, dataContainerView]
    }
    
    var imageUpdateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContainerView(type: .records)
        
        setUpUserListener()
        
        confirmWeekday()
        
        lottieView.isHidden = true
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
            
        case Segue.points:
            
            _ = segue.destination as? SpendPointsViewController

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
    
    func showBlackView() {
        
        blackView.backgroundColor = .black
        
        blackView.alpha = 0.4

        view.insertSubview(blackView, at: 3)
        
        setUpVisualEffect()
    }
    
    private func setUpVisualEffect() {
        
        let effect = UIBlurEffect(style: .dark)
        
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.alpha = 0.6
        
        effectView.frame = blackView.frame
        
        blackView.addSubview(effectView)
    }
    
    private func setUpButtonStyle(_ button: UIButton) {
        
        button.layer.borderColor = UIColor.black252525.cgColor
        
        button.layer.borderWidth = 2
        
        button.layer.cornerRadius = 10
    }
    
    func setUpLottieView() {
        
        let animation = Animation.named("ImageLoading")
        
        lottieView.animation = animation
        
        lottieView.play()
        
        lottieView.loopMode = .loop
    }
    
    func setUpUserListener() {
        
        UserProvider.shared.onFetchUserListener { result in
            
            switch result {
            
            case .success(let user):

                if self.imageUpdateCount <= 0 {

                    self.userImage.loadImage(user.picture, placeHolder: .asset(.user))

                } else {

                    self.imageUpdateCount -= 1
                }
                
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
            
            resetMedal()
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
    
    func resetMedal() {
        
        UserProvider.shared.resetMedal { result in
            
            switch result {
            
            case .success(let success):
                
                print("reset \(success)")
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func setImagePicker() {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        
        picker.delegate = self
        
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    func uploadUserImage(image: UIImage, imageData: Data) {
        
        showBlackView()
        
        setUpLottieView()
        
        lottieView.isHidden = false
        
        StorageProvider.shared.uploadUserImage(imageData: imageData) { [weak self] result in
            
            switch result {
            
            case .success(let imageName):
                
                print("upload image \(imageName)")
                
                self?.changeImageToURL(imageName: imageName)
                
                self?.onImageUploaded(image: image)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func changeImageToURL(imageName: String) {
        
        StorageProvider.shared.changeImageToURL(imageName: imageName) { [weak self] result in
            
            switch result {
            
            case .success(let url):
                
                print("change image to string \(url)")
                
                self?.updateUserImage(imageName: url)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func updateUserImage(imageName: String) {
        
        UserProvider.shared.changeUserImage(imageName: imageName) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print("update user image \(success)")
                
                self?.blackView.removeFromSuperview()
                
                self?.lottieView.isHidden = true

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func onImageUploaded(image: UIImage) {

        userImage.image = image

        imageUpdateCount += 1
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return  }
        
        guard let imageData = image.pngData() else { return }
        
        uploadUserImage(image: image, imageData: imageData)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UINavigationControllerDelegate {
    
}

extension ProfileViewController: SettingDelegate {
    
    func userNameChange() {
        
        performSegue(withIdentifier: Segue.changeName, sender: nil)
    }
    
    func exitGroup() {
        
        performSegue(withIdentifier: Segue.leaveGroup, sender: nil)
    }
    
    func showPickerView() {
        
        setImagePicker()
    }
}
