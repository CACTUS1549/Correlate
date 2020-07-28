//
//  HealthKitDataManager.swift
//  Correlate
//
//  Created by Deepak Reddy on 28/07/20.
//  Copyright © 2020 Deepak Reddy. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitDataManager {
    
    var healthKitDataStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable(){
            print("Health Kit data is available in this device")
            healthKitDataStore = HKHealthStore()
        }
    }
    
    func requestPermissionsAndGetData() {
        let dataTypes = Set([HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])
        healthKitDataStore?.requestAuthorization(toShare: dataTypes, read: dataTypes, completion: { (success, error) in
            if !success{
                //Handle error here.
                fatalError("Coud not get permissions from the user")
            } else{
                print("User permission granted for accessing their health data")
                self.getWalkingRunningDistance()
            }
        })
    }
    
    func getWalkingRunningDistance(){
        
        var distanceInKilometers: Double?
        
        let walkingRunning = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        
        //Hardcoded 7 days back from today's date.
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let endDate = Date()
        
        let anchorDate = Date.weekStartsOnMondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery(quantityType: walkingRunning, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
          
        query.initialResultsHandler = {query, result, error in
            result?.enumerateStatistics(from: startDate!, to: endDate) { (statistics, value) -> Void in
                let count = statistics.sumQuantity()
                let distance = count?.doubleValue(for: HKUnit.mile())
                distanceInKilometers = distance! * 1.609
                print(distanceInKilometers!)
            }
        }
        healthKitDataStore?.execute(query)
    }
    
}
