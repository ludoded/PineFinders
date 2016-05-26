//
//  CarViewModel.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/26/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

enum CarFilter: Int {
    case Make
    case Model
    case Years
    case Body
    case Doors
    case Seats
}

class CarViewModel {
    private var cars = [CarsObject]()
    private var filteredCars = [CarsObject]()
    
    var filteredModels: [String]?
    var filteredMakes: [String]?
    var filteredYears: [String]?
    var filteredDoors: [String]?
    var filteredSeats: [String]?
    var filteredBody: [String]?
    
    var makeFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.make == makeFilter })
        }
    }
    
    var modelFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.model == modelFilter })
        }
    }
    
    var yearsFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.yearsProduced == yearsFilter })
        }
    }
    
    var bodyFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.body == bodyFilter })
        }
    }
    
    var doorsFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.doors == doorsFilter })
        }
    }
    
    var seatsFilter: String? {
        didSet {
            filteredCars = filteredCars.filter({ $0.car.seats == seatsFilter })
        }
    }
    
    func loadData(completionHandler: () -> ()) {
        FirebaseManager.sharedInstance.cars { (cars) in
            self.cars = cars
            self.filteredCars = cars
            completionHandler()
        }
    }
    
    func retrieveMakes() {
        filteredMakes = uniq(filteredCars.map({ $0.car.make }))
    }
    
    func retrieveModels() {
        filteredModels = uniq(filteredCars.map({ $0.car.model }))
    }
    
    func retrieveYears() {
        filteredYears = uniq(filteredCars.map({ $0.car.yearsProduced }))
    }
    
    func retrieveBody() {
        filteredBody = uniq(filteredCars.map({ $0.car.body }))
    }
    
    func retrieveDoors() {
        filteredDoors = uniq(filteredCars.map({ $0.car.doors }))
    }
    
    func retrieveSeats() {
        filteredSeats = uniq(filteredCars.map({ $0.car.seats }))
    }
}