//
//  UnclaimedTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/13.
//

import UIKit

class UnclaimedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var expectedPointsLabel: UILabel!
    
    @IBOutlet weak var acceptTaskButton: UIButton!
    
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCellStyle()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func clickToAcceptTask(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.clickButtonToAccept(at: index)
            
        }
    }
    
    func setUpCellStyle() {
        
        selectionStyle = .none
        
        cellView.backgroundColor = .beigeEBDDCE
    }
    
    func layoutCell(chore: Chore) {
        
        choreItemLabel.text = chore.item
        
        expectedPointsLabel.text = "可獲得 \(chore.points) 點"
        
        if let imageName = ChoreImages.imageNames[chore.item] {
            
            choreImage.image = UIImage(named: imageName)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
    
}

// extension CardView {
//
//  func addDashdeBorderLayer (byView view: UIView, color: UIColor, lineWidth width: CGFloat) {
//  let shapeLayer = CAShapeLayer()
//  let size = view.frame.size
//
//  let shapeRect = CGRect(x: 0, y: 0, width: size.width - 18, height: size.height)
//  shapeLayer.bounds = shapeRect
//  shapeLayer.position = CGPoint(x: view.bounds.midX - 9, y: view.bounds.midY + 3)
//  shapeLayer.fillColor = UIColor.clear.cgColor
//  shapeLayer.strokeColor = color.cgColor
//  shapeLayer.lineWidth = width
//  shapeLayer.lineJoin = CAShapeLayerLineJoin.round
//
//  shapeLayer.lineDashPattern = [3, 4]
//  let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5)
//  shapeLayer.path = path.cgPath
//  view.layer.addSublayer(shapeLayer)
//
//  }
// }
