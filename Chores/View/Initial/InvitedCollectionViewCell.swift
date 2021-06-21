//
//  InvitedCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/27.
//

import UIKit

enum QRCode: String {
    
    case qrcodeCIFilter = "CIQRCodeGenerator"
    
    case qrcodeValue = "inputMessage"
}

class InvitedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var qrcodeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func layoutCell() {
        
        userIdLabel.text = "\(UserProvider.shared.uid ?? "")"
        
        qrcodeImage.image = UIImage.getUserQRCode(from: UserProvider.shared.uid ?? "")
    }
}
