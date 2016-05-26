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
    case MaxLoad
}

class VanViewModel {
    
    private var vans = [VansObject]()
    private var filteredVans = [VansObject]()
    
    var filteredManufacturer: [String]?
    var filteredModels: [String]?
    var filteredYears: [String]?
    var filteredEdition: [String]?
    var filteredMaxload: [String]?
    
    var manufacturerFilter: String? {
        didSet {
            filteredVans = filteredVans.filter({ $0.van.manufacturer == manufacturerFilter })
        }
    }
    
    var modelFilter: String? {
        didSet {
            filteredVans = filteredVans.filter({ $0.van.model == modelFilter })
        }
    }
    
    var yearsFilter: String? {
        didSet {
            filteredVans = filteredVans.filter({ $0.van.loadspaceWidth == yearsFilter })
        }
    }
    
    var editionFilter: String? {
        didSet {
            filteredVans = filteredVans.filter({ $0.van.edition == editionFilter })
        }
    }
    
    var maxloadFilter: String? {
        didSet {
            filteredVans = filteredVans.filter({ $0.van.rearCargoDoorMaxWidth == modelFilter })
        }
    }
    
    func loadData(completionHandler: () -> ()) {
        FirebaseManager.sharedInstance.vans { (vans) in
            self.vans = vans
            self.filteredVans = vans
            completionHandler()
        }
    }
    
    func retrieveManufacturers() {
        filteredManufacturer = uniq(filteredVans.map({ $0.van.manufacturer }))
    }
    
    func retrieveModels() {
        filteredModels = uniq(filteredVans.map({ $0.van.model }))
    }
    
    func retrieveYears() {
        filteredYears = uniq(filteredVans.map({ $0.van.loadspaceWidth }))
    }
    
    func retrieveEditions() {
        filteredEdition = uniq(filteredVans.map({ $0.van.edition }))
    }
    
    func retrieveMaxloads() {
        filteredMaxload = uniq(filteredVans.map({ $0.van.rearCargoDoorMaxWidth }))
    }
}