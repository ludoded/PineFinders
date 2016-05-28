//
//  VanEntryViewModel.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/28/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

class VanEntryViewModel {
    func save(van: VansObject, input1: String, input2: String, input3: String, input4: String, input5: String, completionHandler: (Bool) -> ()) {
        let params = [
            "input 1" : input1,
            "input 2" : input2,
            "input 3" : input3,
            "input 4" : input4,
            "input 5" : input5,
            "Complete" : "true"
        ]
        
        FirebaseManager.sharedInstance.saveVan("\(van.uid)", values: params, completionHandler: completionHandler)
    }
}