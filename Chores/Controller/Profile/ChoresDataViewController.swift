//
//  ChoresDataViewControllerViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit
import Charts

class ChoresDataViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    
    var choresList: [[Chore]] = [] {
        
        didSet {
            
            updateChoreData(choresList: choresList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onFetchRecordsListener()
    }
    
    func updateChoreData(choresList: [[Chore]]) {
        
        var pieChartData: [PieChartDataEntry] = []

        // reduce 後面接的第一個參數是初始值，表示你希望運算從何而起
        // closure 中第一個變數代表每次運算的結果，第二個是每次所傳進去的陣列，把當前的總和與傳進去的元素相加
        let sum = choresList.reduce(0, { (sum, chores) -> Int in

            return sum + chores.count
        })
                
        for chores in choresList {
            
            let percent = Double(chores.count) / Double(sum) * 100.0
            
            pieChartData.append(PieChartDataEntry(value: percent, label: chores[0].item))
        }
        
        let chartDataSet = PieChartDataSet(entries: pieChartData, label: nil)
        
        chartDataSet.sliceSpace = 2
        
        chartDataSet.entryLabelColor = .black

        chartDataSet.colors = ChartColorTemplates.wonderful()

        let chartData = PieChartData(dataSet: chartDataSet)
        
        let pFormatter = NumberFormatter()
        
        pFormatter.numberStyle = .percent
        
        pFormatter.maximumFractionDigits = 1
        
        pFormatter.multiplier = 1
        
        pFormatter.percentSymbol = "%"
        
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))

        chartData.setValueFont(.systemFont(ofSize: 11, weight: .regular))
        
        chartData.setValueTextColor(.black)

        chartView.data = chartData
    }
    
    func onFetchRecordsListener() {

        FirebaseProvider.shared.fetchDifferentChoreType { [weak self] result in
            
            switch result {
            
            case .success(let choresList):
                
                self?.choresList = choresList

            case .failure(let error):
                
                print(error)
            }
        }
    }
}
