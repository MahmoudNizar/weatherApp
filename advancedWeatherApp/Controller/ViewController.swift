//
//  ViewController.swift
//  advancedWeatherApp
//
//  Created by Mahmoud on 12/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var maxAndMinTemp: UILabel!
    @IBOutlet weak var tempreature: UILabel!
    @IBOutlet weak var smallWeatherIcon: UIImageView!
    @IBOutlet weak var bigWeatherIcon: UIImageView!
    @IBOutlet weak var dateOfToday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

