//
//  TableViewCell.swift
//  SPHDemo
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var tipButton: UIButton!
    
    var model: YearDataModel!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 15
            frame.size.width -= 2 * 15
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: YearDataModel) {
        self.model = model
        yearLabel.text = "\(model.year)年"
        volumeLabel.text = "\(model.volumeOfMobileData.roundTo(places: 8)) PB"
        if model.decreasedQuarterArray.count > 0 {
            tipButton.isHidden = false
        } else {
            tipButton.isHidden = true
        }
    }
    
    @IBAction func tipButtonTapped(_ sender: UIButton) {
        print("点击")
        
        var quarterString = ""
        for (index, decreasedQuarter) in model.decreasedQuarterArray.enumerated() {
            if index == 0 {
                quarterString = "\(decreasedQuarter)"
            } else {
                quarterString += "、\(decreasedQuarter)"
            }
        }
        
        let alert = UIAlertController(title: "\(model.year)年第\(quarterString)季度数据量下降", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
        alert.addAction(action)
        
        var nextResponder = self.next
        while nextResponder != nil {
            if nextResponder is ViewController {
                let vc = nextResponder as! ViewController
                vc.present(alert, animated: true, completion: nil)
                break
            }
            nextResponder = nextResponder!.next
        }
    }
    
}
