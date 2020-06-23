//
//  ViewController.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

//LET URL =        https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/37.33233141,-122.031218?exclude=[flags,minutely] //37 LAT -122 LONGITUDE OF APPLE CALIFORNIA
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
        super.viewDidAppear(animated)
        
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
        if !locations.isEmpty , currentLocation == nil
        {
            
           currentLocation =  locations.first
            locationManager.stopUpdatingLocation()
            
            requestForWeatherLocation()
        }
    }
    func requestForWeatherLocation()
    {
    
        
        guard let currentLocation = currentLocation else { return}
        
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"
        
        print("lat: \(lat)  long:\(long)")
        
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    

}

