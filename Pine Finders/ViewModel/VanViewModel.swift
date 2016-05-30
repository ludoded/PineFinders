//
//  VanViewModel.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/26/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import Foundation

enum VanFilter: Int {
    case Manufacturer
    case Model
    case Years
    case Edition
}

class VanViewModel {
    private var vans = [VansObject]()
    private var filteredVans = [VansObject]()
    
    var oneResultRemains: ((VansObject) -> ())?
    
    var filteredManufacturer: [String]?
    var filteredModels: [String]?
    var filteredYears: [String]?
    var filteredEdition: [String]?
    
    var selectedVan: VansObject?
    
    var manufacturerFilter: String?
    var modelFilter: String?
    var yearsFilter: String?
    var editionFilter: String?
    
    func loadData(completionHandler: () -> ()) {
        FirebaseManager.sharedInstance.vans { (vans) in
            self.vans = vans
            self.filteredVans = vans
            completionHandler()
        }
    }
    
    func retrieveManufacturers() {
        filteredManufacturer = uniq(allFilteredCars().map({ $0.van.manufacturer }))
    }
    
    func retrieveModels() {
        filteredModels = uniq(allFilteredCars().map({ $0.van.model }))
    }
    
    func retrieveYears() {
        filteredYears = uniq(allFilteredCars().map({ $0.van.yearsProduces }))
    }
    
    func retrieveEditions() {
        filteredEdition = uniq(allFilteredCars().map({ $0.van.edition }))
    }
    
    private func allFilteredCars() -> [VansObject] {
        var allFiltered = filteredVans
        
        if let safeManufacturerFilter = manufacturerFilter { allFiltered = allFiltered.filter({ $0.van.manufacturer == safeManufacturerFilter }) }
        if let safeModelFilter = modelFilter { allFiltered = allFiltered.filter({ $0.van.model == safeModelFilter }) }
        if let safeYearsFilter = yearsFilter { allFiltered = allFiltered.filter({ $0.van.yearsProduces == safeYearsFilter }) }
        if let safeEditionFilter = editionFilter { allFiltered = allFiltered.filter({ $0.van.edition == safeEditionFilter }) }
        
        if allFiltered.count == 1 {
            oneResultRemains?(allFiltered.first!)
            selectedVan = allFiltered.first
        }
        
        return allFiltered
    }
}