//
//  ViewController.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit
import CoreLocation
struct Weather
{
    
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    
    @IBOutlet weak var tables: UITableView!
    
    var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var Model = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register 2 cell
        
        tables.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        tables.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        
        
        //tables
        tables.delegate = self
        tables.dataSource = self
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpLocation()
    }
    
    //Location
    
    func setUpLocation()
    {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.isEmpty , currentLocation == nil
        {
            
            locations.first
            locationManager.stopUpdatingLocation()
        }
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    

}

