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
  
  var nubmerOfPieChartData = [PieChartDataEntry]()
  var walkDog = PieChartDataEntry(value: 40)
  var washDishes = PieChartDataEntry(value: 50)
  var repair = PieChartDataEntry(value: 10)
  
    override func viewDidLoad() {
        super.viewDidLoad()

      walkDog.value = walkDog.value
      walkDog.label = "遛狗"
      
      washDishes.value = washDishes.value
      washDishes.label = "洗碗"
      
      repair.value = repair.value
      repair.label = "修繕"
      
      nubmerOfPieChartData = [walkDog, washDishes, repair]
      
      updateSelfChoreData()
    }
  
  func updateSelfChoreData() {
    
    let chartDataSet = PieChartDataSet(entries: nubmerOfPieChartData, label: nil)
    let chartData = PieChartData(dataSet: chartDataSet)
    
    let colors = [UIColor.blue7990CA, UIColor.orangeE89E21, UIColor.beigeEBDDCE]
    
    chartDataSet.colors = colors
    
    selfChoreDataView.data = chartData

  }

}
