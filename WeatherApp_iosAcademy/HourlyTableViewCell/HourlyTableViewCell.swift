//
//  HourlyTableViewCell.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [HourlyData]()
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib
      {
     
          return UINib(nibName: "HourlyTableViewCell", bundle: nil)
      }
    
    func configure(with models : [HourlyData])
    {
        self.models = models
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
}
