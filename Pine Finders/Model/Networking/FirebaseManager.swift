//
//  FirebaseManager.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/25/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let sharedInstance = FirebaseManager()
    
    let ref = FIRDatabase.database().reference()
    
    func cars(completionHandler: ([CarsObject]) -> ()) {
        let carRef = ref.child("Cars")
        var cars = [CarsObject]()
        
        carRef.observeEventType(.Value, withBlock: { (snapshot) in
            let dict = snapshot.value as! [[String: AnyObject]]
            
            cars = dict.enumerate()
                .map({ CarsObject(uid: $0, data: $1) })
                .filter({ $0.car.complete.isEmpty })
            
            completionHandler(cars)
        })
    }
    
    func saveCar(carID: String, values: [NSObject : AnyObject], completionHandler:(Bool) -> ()) {
        let carRef = ref.child("Cars").child(carID)
        
        carRef.updateChildValues(values) { (error, _) in
            completionHandler(error == nil)
        }
    }
    
    func vans(completionHandler: ([VansObject]) -> ()) {
        let vanRef = ref.child("Vans")
        var vans = [VansObject]()
        
        vanRef.observeEventType(.Value, withBlock: { (snapshot) in
            let dict = snapshot.value as! [[String: AnyObject]]
            
            vans = dict.enumerate()
                .map({ VansObject(uid: $0, data: $1) })
                .filter({ $0.van.complete.isEmpty })
            
            completionHandler(vans)
        })
    }
    
    func saveVan(vanID: String, values: [NSObject : AnyObject], completionHandler:(Bool) -> ()) {
        let vanRef = ref.child("Vans").child(vanID)
        
        vanRef.updateChildValues(values) { (error, _) in
            completionHandler(error == nil)
        }
    }
}

func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
    var seen: [E:Bool] = [:]
    return source.filter({ (v) -> Bool in
        return seen.updateValue(true, forKey: v) == nil
    })
}