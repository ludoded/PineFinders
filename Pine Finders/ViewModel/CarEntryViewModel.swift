//
//  CarEntryViewModel.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/28/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

class CarEntryViewModel {
    func save(car: CarsObject, input1: String, input2: String, input3: String, input4: String, input5: String, input6: String, input7: String, completionHandler: (Bool) -> ()) {
        let params = [
            "INPUT 1" : input1,
            "INPUT 2" : input2,
            "INPUT 3" : input3,
            "INPUT 4" : input4,
            "INPUT 5" : input5,
            "INPUT 6" : input6,
            "INPUT 7" : input7,
            "COMPLETE" : "true"
        ]
        
        FirebaseManager.sharedInstance.saveCar("\(car.uid)", values: params, completionHandler: completionHandler)
    }
}