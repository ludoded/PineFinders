//
//  CarsFilterViewController.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/25/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import UIKit
import MBProgressHUD

class VansFilterViewController: UITableViewController {
    let viewModel = VanViewModel()
    
    private var selectedFilter: VanFilter?
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var editionLabel: UILabel!
    @IBOutlet weak var maxloadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        viewModel.loadData {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        selectedFilter = VanFilter(rawValue: indexPath.row)
        
        switch selectedFilter! {
        case .Manufacturer:
            viewModel.retrieveManufacturers()
        case .Model:
            viewModel.retrieveModels()
        case .Years:
            viewModel.retrieveYears()
        case .Edition:
            viewModel.retrieveEditions()
        case .MaxLoad:
            viewModel.retrieveMaxloads()
        }
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PickerViewController") as? PickerViewController else { fatalError("Can't load the picker") }
        vc.dataSource = self
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VansFilterViewController: PickerDelegate {
    func didSelectItemAtIndex(index: Int) {
        guard let safeFilter = selectedFilter else { fatalError("Oh My GUsh") }
        
        switch safeFilter {
        case .Manufacturer:
            let filter = viewModel.filteredManufacturer?[index] ?? ""
            viewModel.manufacturerFilter = filter
            manufacturerLabel.text = filter
        case .Model:
            let filter = viewModel.filteredModels?[index] ?? ""
            viewModel.modelFilter = filter
            modelLabel.text = filter
        case .Years:
            let filter = viewModel.filteredYears?[index] ?? ""
            viewModel.yearsFilter = filter
            yearsLabel.text = filter
        case .Edition:
            let filter = viewModel.filteredEdition?[index] ?? ""
            viewModel.editionFilter = filter
            editionLabel.text = filter
        case .MaxLoad:
            let filter = viewModel.filteredMaxload?[index] ?? ""
            viewModel.maxloadFilter = filter
            maxloadLabel.text = filter
        }
    }
}

extension VansFilterViewController: PickerDataSource {
    func itemTitleForIndex(index: Int) -> String {
        guard let safeFilter = selectedFilter else { fatalError("Oh My GUsh") }
        
        switch safeFilter {
        case .Manufacturer:
            return viewModel.filteredManufacturer?[index] ?? ""
        case .Model:
            return viewModel.filteredModels?[index] ?? ""
        case .Years:
            return viewModel.filteredYears?[index] ?? ""
        case .Edition:
            return viewModel.filteredEdition?[index] ?? ""
        case .MaxLoad:
            return viewModel.filteredMaxload?[index] ?? ""
        }
    }
    
    func numberOfItems() -> Int {
        guard let safeFilter = selectedFilter else { fatalError("Oh My Gush") }
        
        switch safeFilter {
        case .Manufacturer:
            return viewModel.filteredManufacturer?.count ?? 0
        case .Model:
            return viewModel.filteredModels?.count ?? 0
        case .Years:
            return viewModel.filteredYears?.count ?? 0
        case .Edition:
            return viewModel.filteredEdition?.count ?? 0
        case .MaxLoad:
            return viewModel.filteredMaxload?.count ?? 0
        }
    }
}