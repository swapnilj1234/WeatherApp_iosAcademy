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

struct Weather:Codable
{
    
    var latitude : Float
    var longitude : Float
    var timezone : String
    var currently : currentlyWeather
    var hourly : hourlyWeather
    var daily : dailyWeather
    var offset : Float
}
struct currentlyWeather:Codable {
    var time : Int
    var summary : String
    var icon : String
    var nearestStormBearing : Int
    var nearestStormDistance : Int
    var precipIntensity : Int
    var precipProbability : Int
    var temperature : Double
    var apparentTemperature : Double
    var dewPoint : Double
    var humidity : Double
    var pressure : Double
    var windSpeed : Double
    var windGust : Double
    var windBearing : Double
    var cloudCover : Double
    var uvIndex : Int
    var visibility : Double
    var ozone : Double
}
struct hourlyWeather:Codable {
    var summary : String
    var icon : String
    var data : [HourlyData]
}

struct HourlyData:Codable {
    
       var time : Int
       var summary : String
       var icon : String
       var precipIntensity : Float
       var precipProbability : Double
       var precipType:String?
       var temperature : Double
       var apparentTemperature : Double
       var dewPoint : Double
       var humidity : Double
       var pressure : Double
       var windSpeed : Double
       var windGust : Double
       var windBearing : Int
       var cloudCover : Double
       var uvIndex : Int
       var visibility : Float?
       var ozone : Double

}

struct dailyWeather:Codable {
       var summary : String
       var icon : String
       var data : [dailyData]
}
struct dailyData:Codable {
    
    var time : Int
    var summary : String
    var icon : String
    var sunriseTime: Int
    var sunsetTime : Int
    var moonPhase : Double
    var precipIntensity : Float
    var precipIntensityMax : Float
    var precipIntensityMaxTime : Int
    var precipProbability : Double
    var precipType : String?
    var temperatureHigh : Double
    var temperatureHighTime: Int
    var temperatureLow: Double
    var temperatureLowTime: Int
    var apparentTemperatureHigh:Double
    var apparentTemperatureHighTime:Int
    var apparentTemperatureLow: Double
    var apparentTemperatureLowTime : Int
    var dewPoint : Double
    var humidity : Double
    var pressure : Double
    var windSpeed : Double
    var windGust : Double
    var windGustTime:Int
    var windBearing : Int
    var cloudCover : Double
    var uvIndex : Int
    var uvIndexTime : Int
    var visibility : Float
    var ozone : Double
    var temperatureMin: Double
    var temperatureMinTime:Int
    var temperatureMax:Double
    var temperatureMaxTime:Int
    var apparentTemperatureMin:Double
    var apparentTemperatureMinTime:Int
    var apparentTemperatureMax:Double
    var apparentTemperatureMaxTime : Int



}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    
    @IBOutlet weak var tables: UITableView!
    
    var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var Model = [dailyData]()
    
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
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            guard let datas = data , error == nil else
            {return
             }
            var json : Weather?
            
            do
            {
                json =  try! JSONDecoder().decode(Weather.self, from: datas)

            }
            catch
            {
                print("error \(error.localizedDescription)")
            }
            guard let result = json else
            {
                return
            }

            let entries = result.daily.data
            
            self.Model.append(contentsOf: entries)
            
            
            //update user interface
            
            DispatchQueue.main.async {
                self.tables.reloadData()
            }

        }.resume()
        
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tables.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.configure(with: Model[indexPath.row])
        
        return cell
    }

    
    

}

