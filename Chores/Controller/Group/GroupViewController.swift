//
//  GroupViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit
import Charts

protocol AddMemberCellDelegate: AnyObject {
    
    func showMemberView()
}

class GroupViewController: UIViewController {
    
    private enum PageType: Int {
        
        case week = 0
        
        case month = 1
        
        case total = 2
    }
    
    //  private struct Segue {
    //
    //    static let week = "SegueWeek"
    //
    //    static let month = "SegueMonth"
    //
    //    static let total = "SegueTotal"
    //
    //  }
    
    @IBOutlet weak var indicatorView: UIView! {
        
        didSet {
            
            indicatorView.backgroundColor = .orangeE89E21
        }
    }
    
    //  @IBOutlet weak var weekDataView: UIView!
    //
    //  @IBOutlet weak var monthDataView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            setUpCollectionView()
        }
    }
    
    @IBOutlet var switchButtons: [UIButton]!
    
    //  var containerViews: [UIView] {
    //
    //    return [weekDataView, monthDataView, totalDataView]
    //
    //  }
        
    var mockCount = 11
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateContainerView(type: .week)
    }
    
    override func viewDidLayoutSubviews() {
        
        indicatorView.center.x = switchButtons[0].center.x
    }
    
    //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //    let identifier = segue.identifier
    //
    //    switch identifier {
    //
    //    case Segue.week:
    //      _ = segue.destination as? MemberDataViewController
    //      weekDataView.backgroundColor = .blue7990CA
    //
    //    case Segue.month:
    //      _ = segue.destination as? MemberDataViewController
    //      monthDataView.backgroundColor = .orangeFBDAA0
    //
    //    case Segue.total:
    //      _ = segue.destination as? MemberDataViewController
    //      totalDataView.backgroundColor = .beigeEBDDCE
    //
    //    default:
    //      return
    //
    //    }
    //
    //  }
    
    //  func setUpChartView() {
    
    //    var entries: [BarChartDataEntry] = []
    
    //    for yyy in 0...10 {
    //      entries.append(BarChartDataEntry(x: Double.random(in: 1...30), y: Double(yyy)))
    //    }
    //
    //    let set = BarChartDataSet(entries: entries, label: "chores")
    //
    //    set.colors = ChartColorTemplates.joyful()
    //
    //    let data = BarChartData(dataSet: set)
    //
    //    horizontalBarChartView.data = data
    //
    //  }
    
    @IBAction func clickSwitchButton(_ sender: UIButton) {
        
        for btn in switchButtons {
            
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        moveIndicatorView(sender: sender)
        
        guard let type = PageType(rawValue: sender.tag) else { return }
        
        updateContainerView(type: type)
    }
    
    private func setUpCollectionView() {
        
        collectionView.registerCellWithNib(
            identifier: String(describing: MemberCollectionViewCell.self),
            bundle: nil)
        
        collectionView.registerCellWithNib(
            identifier: String(describing: AddMemberCell.self),
            bundle: nil)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
    }
    
    private func moveIndicatorView(sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.indicatorView.center.x = self.switchButtons[sender.tag].center.x
        }
    }
    
    private func updateContainerView(type: PageType) {
        
        //    containerViews.forEach({ $0.isHidden = true })
        
        switch type {
        
        case .week:
            
            //      setUpChartView()
            containerView.backgroundColor = .none
            
        //      weekDataView.isHidden = false
        
        case .month:
            //      setUpChartView()
            containerView.backgroundColor = .beigeEBDDCE
            
        //      monthDataView.isHidden = false
        
        case .total:
            //      setUpChartView()
            containerView.backgroundColor = .orangeE89E21
        //      totalDataView.isHidden = false
        
        }
    }
    
}

extension GroupViewController: UICollectionViewDelegate {
    
}

extension GroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mockCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == mockCount - 1 {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: AddMemberCell.self),
                for: indexPath)
            
            guard let addMemberCell = cell as? AddMemberCell else { return cell }
            
            addMemberCell.delegate = self
            
            return addMemberCell
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MemberCollectionViewCell.self),
            for: indexPath)
        
        guard let memberCell = cell as? MemberCollectionViewCell else { return cell }
        
        return memberCell
    }
    
}

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
}

extension GroupViewController: AddMemberCellDelegate {
    
    func showMemberView() {
        
        performSegue(withIdentifier: Segue.addMember, sender: nil)
    }
    
}

//extension GroupViewController: ChartViewDelegate {
//  
//}
