//
//  VansObject.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/26/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

struct VansObject {
    var uid: Int
    var van: Van
    
    init(uid: Int, data: [String: AnyObject]) {
        self.uid = uid
        self.van = Van(data: data)
    }
}

struct Van {
    let manufacturer: String
    let model: String
    let edition: String
    let loadspaceLength: String
    let loadspaceWidth: String
    let loadspaceHeight: String
    let widthBetweenWheelArches: String
    let rearCargoDoorMaxHeight: String
    let rearCargoDoorMaxWidth: String
    var input1: String
    var input2: String
    var input3: String
    var input4: String
    var input5: String
    var complete: String
    
    init(data: [String: AnyObject]) {
        manufacturer = data["Manufacturer"] as! String
        model = data["Model"] as! String
        edition = data["Edition"] as! String
        loadspaceLength = data["Loadspace Length"] as! String
        loadspaceWidth = data["Loadspace Width"] as! String
        loadspaceHeight = data["Loadspace Height"] as! String
        widthBetweenWheelArches = data["Width Between Wheel Arches"] as! String
        rearCargoDoorMaxHeight = data["Rear Cargo Door Max Height"] as! String
        rearCargoDoorMaxWidth = data["Rear Cargo Door Max Width"] as! String
        input1 = data["input 1"] as! String
        input2 = data["input 2"] as! String
        input3 = data["input 3"] as! String
        input4 = data["input 4"] as! String
        input5 = data["input 5"] as! String
        complete = data["Complete"] as! String
    }
}