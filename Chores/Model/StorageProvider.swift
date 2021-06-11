//
//  StorageProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/11.
//

import Foundation
import FirebaseStorage

class StorageProvider {
    
    static let shared = StorageProvider()
    
    lazy var storage = Storage.storage().reference()
    
    
    func uploadUserImage(imageData: Data,
                         completion: @escaping (Result<String, Error>) -> Void) {
        
        let imageName = "images/\(UserProvider.shared.uid ?? "")/\(Date()).png"
        
        let reference = storage.child(imageName)
        
        reference.putData(imageData, metadata: nil) { _, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(imageName))
            }
        }
    }
    
    func changeImageToURL(imageName: String ,completion: @escaping (Result<String, Error>) -> Void) {
                
        let reference = storage.child(imageName)

        reference.downloadURL { url, error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                guard let url = url else { return }
                
                let urlString = url.absoluteString
                
                print("DownloadImage: \(urlString)")
                
                completion(.success(urlString))
            }
        }
    }
    
//    func downloadImage(userImage: UIImage) {
//
//        guard let urlString = UserDefaults.standard.string(forKey: "URL"),
//              let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//
//            guard let data = data, error == nil else { return }
//
//            DispatchQueue.main.async {
//
//                let image = UIImage(data: data)
//                    userImage = image
//            }
//        }
//
//        task.resume()
//    }
}
