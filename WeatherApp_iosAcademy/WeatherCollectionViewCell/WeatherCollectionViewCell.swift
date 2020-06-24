//
//  WeatherCollectionViewCell.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 24/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    static let identifier = "WeatherCollectionViewCell"
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    static func nib() -> UINib
    {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }
    
    func configure(with model:HourlyData)
    {
     
        self.tempLabel.text = "\(model.temperature)"
        //self.iconImage.contentMode = .scaleAspectFit
        if model.icon == "clear-day"
        {
        
        self.iconImage.image = UIImage(named: "sun")
            
        }
        else if model.icon == "rain"
        {
            self.iconImage.image = UIImage(named: "rain")

        }
        else
        {
            self.iconImage.image = UIImage(named: "cloud")

        }
    }
    
    
}
