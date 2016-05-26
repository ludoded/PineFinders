//
//  CarsFilterViewController.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/25/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import UIKit
import MBProgressHUD

class CarsFilterViewController: UITableViewController {
    let viewModel = CarViewModel()
    
    private var selectedFilter: CarFilter?
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var doorsLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        viewModel.loadData { 
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        selectedFilter = CarFilter(rawValue: indexPath.row)
        
        switch selectedFilter! {
        case .Make:
            viewModel.retrieveMakes()
        case .Model:
            viewModel.retrieveModels()
        case .Years:
            viewModel.retrieveYears()
        case .Body:
            viewModel.retrieveBody()
        case .Doors:
            viewModel.retrieveDoors()
        case .Seats:
            viewModel.retrieveSeats()
        }
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PickerViewController") as? PickerViewController else { fatalError("Can't load the picker") }
        vc.dataSource = self
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CarsFilterViewController: PickerDelegate {
    func didSelectItemAtIndex(index: Int) {
        guard let safeFilter = selectedFilter else { fatalError("Oh My GUsh") }
        
        switch safeFilter {
        case .Make:
            let filter = viewModel.filteredMakes?[index] ?? ""
            viewModel.makeFilter = filter
            makeLabel.text = filter
        case .Model:
            let filter = viewModel.filteredModels?[index] ?? ""
            viewModel.modelFilter = filter
            modelLabel.text = filter
        case .Years:
            let filter = viewModel.filteredYears?[index] ?? ""
            viewModel.yearsFilter = filter
            yearsLabel.text = filter
        case .Body:
            let filter = viewModel.filteredBody?[index] ?? ""
            viewModel.bodyFilter = filter
            bodyLabel.text = filter
        case .Doors:
            let filter = viewModel.filteredDoors?[index] ?? ""
            viewModel.doorsFilter = filter
            doorsLabel.text = filter
        case .Seats:
            let filter = viewModel.filteredSeats?[index] ?? ""
            viewModel.seatsFilter = filter
            seatsLabel.text = filter
        }
    }
}

extension CarsFilterViewController: PickerDataSource {
    func itemTitleForIndex(index: Int) -> String {
        guard let safeFilter = selectedFilter else { fatalError("Oh My GUsh") }
        
        switch safeFilter {
        case .Make:
            return viewModel.filteredMakes?[index] ?? ""
        case .Model:
            return viewModel.filteredModels?[index] ?? ""
        case .Years:
            return viewModel.filteredYears?[index] ?? ""
        case .Body:
            return viewModel.filteredBody?[index] ?? ""
        case .Doors:
            return viewModel.filteredDoors?[index] ?? ""
        case .Seats:
            return viewModel.filteredSeats?[index] ?? ""
        }
    }
    
    func numberOfItems() -> Int {
        guard let safeFilter = selectedFilter else { fatalError("Oh My Gush") }
        
        switch safeFilter {
        case .Make:
            return viewModel.filteredMakes?.count ?? 0
        case .Model:
            return viewModel.filteredModels?.count ?? 0
        case .Years:
            return viewModel.filteredYears?.count ?? 0
        case .Body:
            return viewModel.filteredBody?.count ?? 0
        case .Doors:
            return viewModel.filteredDoors?.count ?? 0
        case .Seats:
            return viewModel.filteredSeats?.count ?? 0
        }
    }
}