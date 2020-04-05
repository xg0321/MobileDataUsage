//
//  ViewController.swift
//  SPHDemo
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var emptyDataView: UIView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    var quarterDataModelArray = [QuarterDataModel]()
    var yearDataModelArray = [YearDataModel]()
    let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        quarterDataModelArray.removeAll()
        yearDataModelArray.removeAll()
        self.emptyDataView.isHidden = true
        loadData()
    }
    
    func configYearDataModelArray() {
        for i in 0..<2018 - 2008 + 1 {
            let model = YearDataModel()
            model.year = 2008 + i
            yearDataModelArray.append(model)
        }
    }
    
    func loadData() {
        self.loadingView.isHidden = false
        configYearDataModelArray()
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if let json = json {
                print(json["result"]["records"])
                let jsonArray = json["result"]["records"].arrayValue
                for json in jsonArray {
                    let model = QuarterDataModel(from: json)
                    if model.quarterInt != 0 {
                        self.quarterDataModelArray.append(model)
                    }
                }
                self.processModelArray()
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.loadingView.isHidden = true
                self.emptyDataView.isHidden = true
            } else {
                print(errorInfo)
                self.tableView.isHidden = true
                self.loadingView.isHidden = false
                self.emptyDataView.isHidden = false
            }
        }
//        Alamofire.request(url).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func processModelArray() {
        quarterDataModelArray = quarterDataModelArray.sorted {
            $0.quarterInt < $1.quarterInt
        }
        
        for i in 0..<quarterDataModelArray.count {
            let quarterDataModel = quarterDataModelArray[i]
            let yearInt = quarterDataModel.quarterInt / 10
            yearDataModelArray[yearInt - 2008].volumeOfMobileData += quarterDataModel.volumeOfMobileData
            
            if i < quarterDataModelArray.count - 1 {
                let nextQuarterDataModel = quarterDataModelArray[i + 1]
                if nextQuarterDataModel.volumeOfMobileData < quarterDataModel.volumeOfMobileData {
                    let year = nextQuarterDataModel.quarterInt / 10
                    let quarter = nextQuarterDataModel.quarterInt % 10
                    yearDataModelArray[year - 2008].decreasedQuarterArray.append(quarter)
                }
            }
        }
        
        for model in yearDataModelArray {
            print(model.year, model.volumeOfMobileData, model.decreasedQuarterArray)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return yearDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.config(with: yearDataModelArray[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}

