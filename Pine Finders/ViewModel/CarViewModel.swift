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
    
    var oneResultRemains: ((CarsObject) -> ())?
    
    var filteredModels: [String]?
    var filteredMakes: [String]?
    var filteredYears: [String]?
    var filteredDoors: [String]?
    var filteredSeats: [String]?
    var filteredBody: [String]?
    
    var selectedCar: CarsObject?
    
    var makeFilter: String?
    var modelFilter: String?
    var yearsFilter: String?
    var bodyFilter: String?
    var doorsFilter: String?
    var seatsFilter: String?
    
    func loadData(completionHandler: () -> ()) {
        FirebaseManager.sharedInstance.cars { (cars) in
            self.cars = cars
            self.filteredCars = cars
            completionHandler()
        }
    }
    
    func retrieveMakes() {
        filteredMakes = uniq(allFilteredCars().map({ $0.car.make }))
    }
    
    func retrieveModels() {
        filteredModels = uniq(allFilteredCars().map({ $0.car.model }))
    }
    
    func retrieveYears() {
        filteredYears = uniq(allFilteredCars().map({ $0.car.yearsProduced }))
    }
    
    func retrieveBody() {
        filteredBody = uniq(allFilteredCars().map({ $0.car.body }))
    }
    
    func retrieveDoors() {
        filteredDoors = uniq(allFilteredCars().map({ $0.car.doors }))
    }
    
    func retrieveSeats() {
        filteredSeats = uniq(allFilteredCars().map({ $0.car.seats }))
    }
    
    private func allFilteredCars() -> [CarsObject] {
        var allFiltered = filteredCars
        
        if let safeMakeFilter = makeFilter { allFiltered = allFiltered.filter({ $0.car.make == safeMakeFilter }) }
        if let safeModelFilter = modelFilter { allFiltered = allFiltered.filter({ $0.car.model == safeModelFilter }) }
        if let safeyearsFilter = yearsFilter { allFiltered = allFiltered.filter({ $0.car.yearsProduced == safeyearsFilter }) }
        if let safeBodyFilter = bodyFilter { allFiltered = allFiltered.filter({ $0.car.body == safeBodyFilter }) }
        if let safeDoorsFilter = doorsFilter { allFiltered = allFiltered.filter({ $0.car.doors == safeDoorsFilter }) }
        if let safeSeatsFilter = seatsFilter { allFiltered = allFiltered.filter({ $0.car.seats == safeSeatsFilter }) }
        
        if allFiltered.count == 1 {
            oneResultRemains?(allFiltered.first!)
            selectedCar = allFiltered.first
        }
        
        return allFiltered
    }
}