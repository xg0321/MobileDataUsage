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
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    // MARK: - 点击事件
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        quarterDataModelArray.removeAll()
        yearDataModelArray.removeAll()
        self.emptyDataView.isHidden = true
        loadData()
    }
    
    // MARK: - 自定义方法
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
                print(json)
                let jsonArray = json["result"]["records"].arrayValue
                for json in jsonArray {
                    let model = QuarterDataModel(from: json)
                    if model.quarterInt != 0 {
                        self.quarterDataModelArray.append(model)
                    }
                }
                self.processModelArray()
                self.hideEmptyDataView()
            } else {
                print(errorInfo)
                if let modelArray = self.loadCache() {
                    print("读取缓存")
                    self.yearDataModelArray = modelArray
                    self.hideEmptyDataView()
                } else {
                    print("没有缓存")
                    self.showEmptyDataView()
                }
            }
        }
    }
    
    func showEmptyDataView() {
        self.tableView.isHidden = true
        self.loadingView.isHidden = false
        self.emptyDataView.isHidden = false
    }
    
    func hideEmptyDataView() {
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.loadingView.isHidden = true
        self.emptyDataView.isHidden = true
    }
    
    func processModelArray() {
        // 按季度排序
        quarterDataModelArray = quarterDataModelArray.sorted {
            $0.quarterInt < $1.quarterInt
        }
        
        for i in 0..<quarterDataModelArray.count {
            // 计算年度使用量
            let quarterDataModel = quarterDataModelArray[i]
            let yearInt = quarterDataModel.quarterInt / 10
            yearDataModelArray[yearInt - 2008].volumeOfMobileData += quarterDataModel.volumeOfMobileData
            
            // 找出使用量下降的季度
            if i < quarterDataModelArray.count - 1 {
                let nextQuarterDataModel = quarterDataModelArray[i + 1]
                if nextQuarterDataModel.volumeOfMobileData < quarterDataModel.volumeOfMobileData {
                    let year = nextQuarterDataModel.quarterInt / 10
                    let quarter = nextQuarterDataModel.quarterInt % 10
                    yearDataModelArray[year - 2008].decreasedQuarterArray.append(quarter)
                }
            }
        }
        
        saveCache()
        
//        for model in yearDataModelArray {
//            print(model.year, model.volumeOfMobileData, model.decreasedQuarterArray)
//        }
    }
    
    func saveCache() {
        if let data = try? PropertyListEncoder().encode(yearDataModelArray) {
            UserDefaults.standard.set(data, forKey: "data")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadCache() -> [YearDataModel]? {
        if let data = UserDefaults.standard.data(forKey: "data") {
            let modelArray = try? PropertyListDecoder().decode([YearDataModel].self, from: data)
            return modelArray
        }
        return nil
    }
    
    // MARK: - UITableView代理
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
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

