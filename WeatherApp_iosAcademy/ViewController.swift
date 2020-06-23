//
//  ViewController.swift
//  WeatherApp_iosAcademy
//
//  Created by swapnil jadhav on 23/06/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

struct Weather
{
    
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tables: UITableView!
    
    var Model = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tables.delegate = self
        tables.dataSource = self
        
        
    }
    
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    

}

