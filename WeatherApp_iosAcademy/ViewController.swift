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
import MapKit

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
    
    var current : currentlyWeather?
    
    var Model = [dailyData]()
    
    var hourlyModel = [HourlyData]()
    
    var locationName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register 2 cell
        
        tables.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        tables.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        
        
        //tables
        tables.delegate = self
        tables.dataSource = self
        
        tables.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
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
    
        //var indiacator = uiactiv
        guard let currentLocation = currentLocation else { return}

        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude


        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

        //let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

        //let region = MKCoordinateRegion(center: coordinate, span: span)

        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)


        let pin = MKPointAnnotation()
        pin.coordinate = coordinate

        geocoder.reverseGeocodeLocation(location) { (placemark ,error) in

            let place = placemark

            let dic = place![0].addressDictionary as? [String : Any]
                        let name = dic?["Name"] as? String
                        let city = dic!["City"] as? String

                        pin.title = name
                        pin.subtitle = city


            self.locationName = name!

        }

        print(lat,long)
        
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
            
            //current data
            
            let currents = result.currently
            self.current = currents
            
            //hourly data
            
            self.hourlyModel = result.hourly.data
            
            
            
            //update user interface
            
            DispatchQueue.main.async {
                self.tables.reloadData()
                
                self.tables.tableHeaderView = self.createTableHeader()
                
            }

        }.resume()
        
    }
    
    func createTableHeader() -> UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250))
        
        headerView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
//        let locationLabel = UILabel(frame: CGRect(x: 10, y: 5, width: view.frame.size.width-20, height: 40))
//        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: 20))
//        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/2))
//
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/2))

        
        headerView.addSubview(locationLabel)
        headerView.addSubview(tempLabel)
        headerView.addSubview(summaryLabel)
        
        locationLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        //Name for Location
        
        
        
        locationLabel.text = locationName
        
        
        guard let currentWeather = self.current else { return UIView() }
        
        
        tempLabel.text = "\(currentWeather.temperature)"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.summary
        
        return headerView
        
        
    }
    
    //Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            //1 cell that is collectionviewcell
            return 1
        }
        
        return Model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0
        {
            let cell = tables.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModel)
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            
            return cell
            
        }
        
        
        let cell = tables.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.configure(with: Model[indexPath.row])
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}

