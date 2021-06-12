//
//  SettingViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/26.
//

import UIKit
import Lottie

protocol SettingDelegate: AnyObject {
    
    func userNameChange()
    
    func onImageUploaded(image: UIImage)
    
    func exitGroup()
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var popView: CardView!
    
   
    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet weak var changeNameButton: UIButton! {
        
        didSet {
            
            setUpButtonStyle(changeNameButton)
        }        
    }
    
    @IBOutlet weak var changePictureButton: UIButton! {
        
        didSet {
            
            setUpButtonStyle(changePictureButton)
        }
    }
    
    @IBOutlet weak var leaveGroupButton: UIButton! {
        
        didSet {
            
            setUpButtonStyle(leaveGroupButton)
        }
    }
    
    weak var delegate: SettingDelegate?
    
    let blackView = UIView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLottieView()
        
        lottieView.isHidden = true
        
        showBlackView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch? = touches.first
        
        if touch?.view != popView {
            
            blackView.removeFromSuperview()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    // 或是按下更改暱稱會 delegate 回去 profile page 再去更改暱稱頁面 這樣就可以直接 dismiss 回 profile
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        guard let destination = segue.destination as? ChangeNameViewController else { return }
//        
//        destination.delegate = self
//    }
    
    @IBAction func changeName(_ sender: Any) {
        
        blackView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
        
        self.delegate?.userNameChange()
        
//        popView.isHidden = true
//
//        blackView.removeFromSuperview()
//
//        performSegue(withIdentifier: Segue.changeName, sender: nil)
    }

    @IBAction func changePicture(_ sender: Any) {
        
         setImagePicker()
    }

    @IBAction func leaveGroup(_ sender: Any) {
        
        blackView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
        
        self.delegate?.exitGroup()
        
//        self.delegate?.exitGroup()
        
//        popView.isHidden = true
//
//
//        performSegue(withIdentifier: Segue.leaveGroup, sender: nil)
    }
    
    private func showBlackView() {
        
        blackView.backgroundColor = .clear
        
        presentingViewController?.view.addSubview(blackView)
        
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
    
    func setImagePicker() {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        
        picker.delegate = self
        
        picker.allowsEditing = true

        present(picker, animated: true) { [weak self] in

            self?.popView.removeFromSuperview()
            
            self?.blackView.removeFromSuperview()
        }
    }
    
    func uploadUserImage(image: UIImage, imageData: Data) {
        
        lottieView.isHidden = false
        
        showBlackView()
        
        StorageProvider.shared.uploadUserImage(imageData: imageData) { [weak self] result in
            
            switch result {
            
            case .success(let imageName):
                
                print("upload image \(imageName)")

                self?.changeImageToURL(imageName: imageName)
                
                self?.delegate?.onImageUploaded(image: image)
                
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
                
                self?.dismiss(animated: true, completion: nil)
            
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
//
//extension SettingViewController: ProfileDelegate {
//    
//    func backToProfile() {
//        
//        dismiss(animated: true, completion: nil)
//        
//        blackView.removeFromSuperview()
//    }
//}

extension SettingViewController: UIImagePickerControllerDelegate {
    
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

extension SettingViewController: UINavigationControllerDelegate {
    
}
