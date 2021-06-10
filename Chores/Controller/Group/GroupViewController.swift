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
    
    enum PageType: Int {
        
        case week = 0
        
        case month = 1
        
        case total = 2
    }

    @IBOutlet weak var indicatorView: UIView! {
        
        didSet {
            
            indicatorView.backgroundColor = .darkBlue14213D
        }
    }

    @IBOutlet weak var chartView: HorizontalBarChartView! {
        
        didSet {
            
            chartView.delegate = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            setUpCollectionView()
        }
    }
    @IBOutlet var switchButtons: [UIButton]!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var groupMembers: [User] = []
    
    var userNames: [String] = []
    
    var userTotalPoints: [Int] = []
    
    var userWeekPoints: [Int] = []
    
    var userMonthPoints: [Int] = []
    
    var userWeekHours: [Int] = []
    
    var userMonthHours: [Int] = []
    
    var userTotalHours: [Int] = []
    
    var isDisplayPoints: Bool = true
    
    var currentPageType: PageType = .week

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGroupMember()
    }
    
    override func viewDidLayoutSubviews() {
        
        indicatorView.center.x = switchButtons[0].center.x
    }
    
    @IBAction func clickSwitchButton(_ sender: UIButton) {
        
        for btn in switchButtons {
            
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        moveIndicatorView(sender: sender)
        
        guard let type = PageType(rawValue: sender.tag) else { return }
        
        currentPageType = type
        
        updateContainerView(type: currentPageType)
    }
    
    @IBAction func clickSegmentedControl(_ sender: Any) {
        
        isDisplayPoints = segmentedControl.selectedSegmentIndex == 0
        
        updateContainerView(type: currentPageType)
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
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func moveIndicatorView(sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.indicatorView.center.x = self.switchButtons[sender.tag].center.x
        }
    }
    
    private func updateContainerView(type: PageType) {

        switch type {
        
        case .week:
            
            if isDisplayPoints {
                
                setUpChartData(names: userNames, data: userWeekPoints)
                
            } else {
                
                setUpChartData(names: userNames, data: userWeekHours)
            }
            
        case .month:
            
            if isDisplayPoints {
                
                setUpChartData(names: userNames, data: userMonthPoints)
                
            } else {
                
                setUpChartData(names: userNames, data: userMonthHours)
            }
        
        case .total:
            
            if isDisplayPoints {
                
                setUpChartData(names: userNames, data: userTotalPoints)
                
            } else {
                
                setUpChartData(names: userNames, data: userTotalHours)
            }
        }
    }
    
    func fetchGroupMember() {
        
        UserProvider.shared.fetchGroupMember { [weak self] result in
            
            switch result {
            
            case .success(let users):
                
                print(users)

                self?.groupMembers = users
                
                // 避免user離開群組之後會觸發SnapShotListener
                if UserProvider.shared.user.groupId?.isEmpty ?? true {
                    
                    return
                }
                
                self?.userNames = []
                
                self?.userTotalPoints = []
                
                self?.userTotalHours = []
                
                self?.userWeekHours = []
                
                for user in self?.groupMembers ?? [] {
                    
                    self?.userNames.append(user.name)
                    
                    self?.userTotalPoints.append(user.points) // 拿到 user 們的總點數

                    self?.userTotalHours.append(user.totalHours) // 拿到user們的總時數
                    
                    self?.userWeekHours.append(user.weekHours) // 拿到user們的每週時數
                }
 
                self?.fetchWeekData()
                
                self?.fetchMonthData()
                
                self?.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func fetchWeekData() {
        
        FirebaseProvider.shared.fetchWeekData { [weak self] result in
            
            switch result {
            
            case .success(let chores):
                
                print(chores)
                
                self?.userWeekPoints = []
                
                for user in self?.groupMembers ?? [] {
                    
                    // filter
                    let filter = chores.filter { $0.owner == user.id }
                    
                    let sum = filter.reduce(0, { (sum, chore) -> Int in
                        
                        return sum + chore.points
                    })
                    
                    self?.userWeekPoints.append(sum)
                }
                
                self?.updateContainerView(type: self?.currentPageType ?? .week)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func fetchMonthData() {
        
        FirebaseProvider.shared.fetchMonthData { [weak self] result in
            
            switch result {
            
            case .success(let chores):
                
                print(chores)
                
                self?.userMonthHours = []
     
                self?.userMonthPoints = []
                
                for user in self?.groupMembers ?? [] {
                    
                    // filter出chore的owner與user id相同的
                    let filter = chores.filter { $0.owner == user.id }
                    
                    //用filter出來的新資料去reduce 一筆加一筆
                    let hoursSum = filter.reduce(0, { (sum, chore) -> Int in
                        
                        return sum + chore.hours
                    })
                    
                    self?.userMonthHours.append(hoursSum)
                    
                    let pointsSum = filter.reduce(0, { (sum, chore) -> Int in
                        
                        return sum + chore.points
                    })
                    
                    self?.userMonthPoints.append(pointsSum)
                }

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func setUpChartData(names: [String], data: [Int]) {
        
        var chartData: [BarChartDataEntry] = []
        
        for index in 0..<groupMembers.count {
            
            let value = BarChartDataEntry(x: Double(index), y: Double(data[index]))
            
            chartData.append(value)
        }

        setUpChartView(names: names, chartData: chartData)
    }
    
    func setUpChartView(names: [String], chartData: [BarChartDataEntry]) {
        
        let dataSet = BarChartDataSet(entries: chartData, label: "小屋成員數據統計")
        
        dataSet.colors = ChartColorTemplates.shared.wonderful()
        
        dataSet.drawValuesEnabled = false

        let data = BarChartData(dataSets: [dataSet])
        
        data.barWidth = 0.5
        
        chartView.data = data
        
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
        
        chartView.xAxis.axisMaximum = Double(names.count)
        
        chartView.xAxis.axisMinimum = -1
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        
        chartView.xAxis.setLabelCount(names.count, force: false)
        
        chartView.xAxis.granularity = 1
        
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 11)

        chartView.doubleTapToZoomEnabled = false
        
        chartView.pinchZoomEnabled = false
        
        chartView.reloadInputViews()

        let topAxis = chartView.leftAxis
        
        topAxis.drawGridLinesEnabled = false
        
        topAxis.drawLabelsEnabled = false
        
        topAxis.drawAxisLineEnabled = false
        
        topAxis.axisMinimum = 0.1
        
        chartView.rightAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.granularityEnabled = true
        
        chartView.rightAxis.granularity = 10
        
        chartView.maxVisibleCount = 60
        
        chartView.notifyDataSetChanged()
        
        chartView.animate(yAxisDuration: 2)
    }
}

extension GroupViewController: UICollectionViewDelegate {
    
}

extension GroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groupMembers.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        if index == groupMembers.count {
            
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
        
        memberCell.layoutCell(user: groupMembers[index])
        
        return memberCell
    }
}

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let fullSize = UIScreen.main.bounds
        
//        return CGSize(width: fullSize.width * 0.16, height: fullSize.height * 0.1)
        
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

extension GroupViewController: ChartViewDelegate {

}
