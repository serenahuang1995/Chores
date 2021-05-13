//
//  UnclaimedCellView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/13.
//

import UIKit

class UnclaimedCellView: UITableViewCell {

  @IBOutlet weak var cellView: CardView! {
    didSet {
      self.backgroundColor = .whiteF6F7F9
    }
  }

  override func layoutSubviews() {

    self.cellView.addDashdeBorderLayer(byView: cellView, color: .black, lineWidth: 1)

  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

}

extension CardView {

  func addDashdeBorderLayer(byView view: UIView, color: UIColor, lineWidth width: CGFloat){
  let shapeLayer = CAShapeLayer()
  let size = view.frame.size

  let shapeRect = CGRect(x: 0, y: 0, width: size.width - 18, height: size.height)
  shapeLayer.bounds = shapeRect
  shapeLayer.position = CGPoint(x: view.bounds.midX - 9, y: view.bounds.midY + 3)
  shapeLayer.fillColor = UIColor.clear.cgColor
  shapeLayer.strokeColor = color.cgColor
  shapeLayer.lineWidth = width
  shapeLayer.lineJoin = CAShapeLayerLineJoin.round

  shapeLayer.lineDashPattern = [3, 4]
  let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5)
  shapeLayer.path = path.cgPath
  view.layer.addSublayer(shapeLayer)

  }
}
