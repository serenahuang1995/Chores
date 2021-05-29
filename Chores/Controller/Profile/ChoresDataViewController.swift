//
//  ChoresDataViewControllerViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit
import Charts

class ChoresDataViewController: UIViewController {
    
    @IBOutlet weak var selfChoreDataView: PieChartView!
    
    var finishedChoresList: [[Chore]] = [] {
        
        didSet {
            
            updateSelfChoreData(choresList: finishedChoresList)
        }
    }
    
//    var nubmerOfPieChartData = [PieChartDataEntry]()
//
//    var walkDog = PieChartDataEntry(value: 50)
////
//    var washDishes = PieChartDataEntry(value: 50)
////
//    var repair = PieChartDataEntry(value: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nubmerOfPieChartData.append(finishedChoresList)
        
//        walkDog.value = walkDog.value
//        walkDog.label = "遛狗"
//
//        washDishes.value = washDishes.value
//        washDishes.label = "洗碗"
//
//        repair.value = repair.value
//        repair.label = "修繕"
//
//        nubmerOfPieChartData = [walkDog, washDishes, repair]
        
//        updateSelfChoreData()
        
        setUpRecordsListener()
    }
    
    func updateSelfChoreData(choresList: [[Chore]]) {
        
        var pieChartData: [PieChartDataEntry] = Array()
        
        let sum = choresList.reduce(0, { (sum, chores) -> Int in
            
//            print("sum = \(sum)", "\(chores[0].item)", "\(chores.count)")
                      
            return sum + chores.count
        })
                
        for chores in choresList {
            
            let percent = Double(chores.count) / Double(sum) * 100.0
            
            pieChartData.append(PieChartDataEntry(value: percent, label: chores[0].item))
        }
        
        let chartDataSet = PieChartDataSet(entries: pieChartData, label: nil)
        
        chartDataSet.sliceSpace = 2
        
        chartDataSet.entryLabelColor = .black

        chartDataSet.colors = ChartColorTemplates.liberty()

        let chartData = PieChartData(dataSet: chartDataSet)
        
        let pFormatter = NumberFormatter()
        
        pFormatter.numberStyle = .percent
        
        pFormatter.maximumFractionDigits = 1
        
        pFormatter.multiplier = 1
        
        pFormatter.percentSymbol = "%"
        
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))

        chartData.setValueFont(.systemFont(ofSize: 11, weight: .regular))
        
        chartData.setValueTextColor(.black)

        selfChoreDataView.data = chartData
    }
    
    func setUpRecordsListener() {

        FirebaseProvider.shared.fetchDifferentChoreType { [weak self] result in
            
            switch result {
            
            case .success(let choresList):
                
                self?.finishedChoresList = choresList

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
}
