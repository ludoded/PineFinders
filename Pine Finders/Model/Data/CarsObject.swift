//
//  CarsObject.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/25/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

struct CarsObject {
    var uid: Int
    var car: Car
    
    init(uid: Int, data: [String: AnyObject]) {
        self.uid = uid
        self.car = Car(data: data)
    }
}

struct Car {
    let make: String
    let model: String
    let yearsProduced: String
    let body: String
    let doors: String
    let seats: String
    let wheelbase: String
    let length: String
    let width: String
    let height: String
    let lwh: String
    let curbWeight: String
    let cargoSpace: String
    let displacement: String
    let power: String
    let topSpeed: String
    var input1: String
    var input2: String
    var input3: String
    var input4: String
    var input5: String
    var input6: String
    var input7: String
    var complete: String
    
    init(data: [String: AnyObject]) {
        make = data["Make"] as! String
        model = data["Model"] as! String
        yearsProduced = data["Years produced"] as! String
        body = data["Body"] as! String
        doors = data["Doors"] as! String
        seats = data["Seats"] as! String
        wheelbase = data["Wheelbase"] as! String
        length = data["Length"] as! String
        width = data["Width"] as! String
        height = data["Height"] as! String
        lwh = data["L_W_H"] as! String
        curbWeight = data["Curb weight"] as! String
        cargoSpace = data["Cargo space"] as! String
        displacement = data["Displacement"] as! String
        power = data["Power"] as! String
        topSpeed = data["Top speed"] as! String
        input1 = data["INPUT 1"] as! String
        input2 = data["INPUT 2"] as! String
        input3 = data["INPUT 3"] as! String
        input4 = data["INPUT 4"] as! String
        input5 = data["INPUT 5"] as! String
        input6 = data["INPUT 6"] as! String
        input7 = data["INPUT 7"] as! String
        complete = data["COMPLETE"] as! String
    }
}