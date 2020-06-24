//
//  WeatherTableViewCell.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    @IBOutlet var dayLable : UILabel!
    @IBOutlet var lowTempLable : UILabel!
    @IBOutlet var highTempLable : UILabel!
    @IBOutlet var iconImageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib
      {
     
          return UINib(nibName: "WeatherTableViewCell", bundle: nil)
      }
    
    func configure(with Model:dailyData)
    {
        
        //self.highTempLable.textAlignment = .center
        //self.lowTempLable.textAlignment = .center
        self.highTempLable.text = "\(Int(Model.temperatureLow))°"
        self.lowTempLable.text = "\(Int(Model.temperatureHigh))"
        self.dayLable.text = getDayForDate(Date(timeIntervalSince1970: Double(Model.time)))
        //self.imageView?.contentMode = .scaleAspectFit
        
        
        let icon = Model.icon
        
        if icon.contains("clear-day")
        {
            
             self.imageView?.image = UIImage(named: "sun")

        }
        else if icon.contains("rain")
        {
            
            self.imageView?.image = UIImage(named: "rain")

        }
        else
        {
        self.imageView?.image = UIImage(named: "cloud")
        }
    }
    
    func getDayForDate(_ date : Date?) -> String
    {
        guard let inputDate = date else
        {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" //monday
        return formatter.string(from: inputDate)
    }
    
}
