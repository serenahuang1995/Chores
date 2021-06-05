//
//  MemberDataViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit
import Charts

class MemberDataViewController: UIViewController {
    
    @IBOutlet weak var barChartView: HorizontalBarChartView!
    
    var entries: [BarChartDataEntry] = []
    
    var groupMembers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartView.delegate = self
        
        setUpChartView()    
    }
    
    func setUpChartView() {
        
        let xxx = 30.0
        
        let yyy = 4.0
        
        let rrr = 25.0
        
        let ttt = 5.0
        
        entries.append(BarChartDataEntry(x: xxx, y: yyy))
        
        entries.append(BarChartDataEntry(x: rrr, y: ttt))
        
        let set = BarChartDataSet(entries: entries, label: "chores")
        
        set.colors = ChartColorTemplates.liberty()
        
        let data = BarChartData(dataSet: set)
        
        barChartView.data = data
    }
    
}

extension MemberDataViewController: ChartViewDelegate {
    
}
