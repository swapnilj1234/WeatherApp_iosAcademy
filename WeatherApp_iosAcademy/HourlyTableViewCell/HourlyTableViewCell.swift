//
//  HourlyTableViewCell.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib
      {
     
          return UINib(nibName: "HourlyTableViewCell", bundle: nil)
      }
    
}
