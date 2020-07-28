//
//  ViewController.swift
//  Correlate
//
//  Created by Deepak Reddy on 28/07/20.
//  Copyright © 2020 Deepak Reddy. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var healthStore = HealthKitDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthStore.requestPermissionsAndGetData()
    }
 
}

