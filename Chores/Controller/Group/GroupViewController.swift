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
    
//    @IBOutlet weak var barChartView: UIView!
    
    @IBOutlet weak var chartView: HorizontalBarChartView! {
        
        didSet {
            
            chartView.delegate = self
        }
    }

//    @IBOutlet weak var hoursChartView: HorizontalBarChartView! {
//
//        didSet {
//
//            hoursChartView.delegate = self
//        }
//    }
    
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
        
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var groupMembers: [User] = []
    
    var userNames: [String] = []
    
    var userTotalPoints: [Int] = []
    
    var userWeekPoints: [Int] = []
    
    var userMonthPoint: [Int] = []
    
    var userWeekHours: [Int] = []
    
    var userMonthHours: [Int] = []
    
    var userTotalHours: [Int] = []
    
    var chartData: [ChartDataEntry] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchGroupMember()
        
        updateContainerView(type: .week)
        
        confirmWeekday()

    }
    
    override func viewDidLayoutSubviews() {
        
        indicatorView.center.x = switchButtons[0].center.x
    }
    
//      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let destination = segue.destination as? MemberDataViewController else { return }
//
//        destination.groupMembers = groupMembers
//        let identifier = segue.identifier
//
//        switch identifier {
//
//        case Segue.week:
//          _ = segue.destination as? MemberDataViewController
//          weekDataView.backgroundColor = .blue7990CA
//
//        case Segue.month:
//          _ = segue.destination as? MemberDataViewController
//          monthDataView.backgroundColor = .orangeFBDAA0
//
//        case Segue.total:
//          _ = segue.destination as? MemberDataViewController
//          totalDataView.backgroundColor = .beigeEBDDCE
//
//        default:
//          return
    
//        }
    
    @IBAction func clickSwitchButton(_ sender: UIButton) {
        
        for btn in switchButtons {
            
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        moveIndicatorView(sender: sender)
        
        guard let type = PageType(rawValue: sender.tag) else { return }
        
        updateContainerView(type: type)
    }
    
    @IBAction func clickSegmentedControl(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            print("時數")
        } else {
            
            print("點數")
        }
        
    }
    
    func confirmWeekday() {
        
        let number = 7
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd EEEE HH:mm:ss"
        
        let currentDateString = dateFormatter.string(from: date)
        
        print("Current date is \(currentDateString)")
        
        if let date = dateFormatter.date(from: currentDateString) {
            
            print(date)
            
            let numberOfDays = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
            
            print(numberOfDays)
            
            if numberOfDays <= number {
                
             print("DateVar with in number of days")
            }
            
            let test = Calendar.current
            
            print(test)
            
            let dateComponents = DateComponents(calendar: Calendar.current)
            
            print(dateComponents)
            
            switch number {
            case 0:
                print(date)
            case 1:
                print(numberOfDays)
            case 2:
                print(numberOfDays)
            case 3:
                print(numberOfDays)
            case 4:
                print(numberOfDays)
            case 5:
                print(numberOfDays)
            case 6:
                print(numberOfDays)
            default:
                return
            }
        }
        
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
            
             setUpPointsChartData(names: userNames, data: userWeekHours)
            
//            setUpTotalPointsChartView()
            
//                  setUpTotalPointsChartView(users: groupMembers)
//            containerView.backgroundColor = .none
            
        //      weekDataView.isHidden = false
        
        case .month:
            
            setUpPointsChartData(names: userNames, data: userTotalPoints)

//            containerView.backgroundColor = .beigeEBDDCE
            
        //      monthDataView.isHidden = false
        
        case .total:
            
            setUpPointsChartData(names: userNames, data: userTotalPoints)

//                  setUpTotalPointsChartView()
//            containerView.backgroundColor = .orangeE89E21
        //      totalDataView.isHidden = false
        
        }
    }
    
    func fetchGroupMember() {
        
        UserProvider.shared.fetchGroupMember { result in
            
            switch result {
            
            case .success(let users):
                
                print(users)
                
                self.groupMembers = users
                
                for user in self.groupMembers {
                    
                    self.userNames.append(user.name)
                }
                
                print(self.userNames)
                
                for user in self.groupMembers {
                    
                    // 拿到 user 們的總點數
                    self.userTotalPoints.append(user.points)
                }
                
                print(self.userTotalPoints)
                
                for user in self.groupMembers {
                    
                    // 拿到user們的每週時數
                    self.userWeekHours.append(user.weekHours)
                }
                        
                for user in self.groupMembers {
                    
                    self.userTotalHours.append(user.totalHours)
                }
                
                self.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func setUpPointsChartData(names: [String], data: [Int]) {
        
        for index in 0..<userTotalPoints.count {
            let value = BarChartDataEntry(x: Double(index), y: Double(data[index]))
            chartData.append(value)
        }
        
        setUpPointsChartView(names: names)
    }
    
    func setUpPointsChartView(names: [String]) {
        
        let dataSet = BarChartDataSet(entries: chartData)
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.drawValuesEnabled = false
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.5
        chartView.data = data
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.axisMaximum = Double(names.count)
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)

        let topAxis = chartView.leftAxis
        topAxis.drawGridLinesEnabled = false
        topAxis.drawLabelsEnabled = false
        topAxis.drawAxisLineEnabled = false
        topAxis.axisMinimum = 0.1
        
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.granularityEnabled = true
        chartView.rightAxis.granularity = 10
//        barChartView.maxVisibleCount = 60
        chartView.notifyDataSetChanged()
        chartView.animate(yAxisDuration: 2)
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12)
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
