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
    
    @IBOutlet weak var manufacturerCell: UITableViewCell!
    @IBOutlet weak var modelCell: UITableViewCell!
    @IBOutlet weak var yearsCell: UITableViewCell!
    @IBOutlet weak var editionCell: UITableViewCell!
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var editionLabel: UILabel!
    
    @IBOutlet weak var enter: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.oneResultRemains = foundOnlyVan
        initialSetup()
        
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
        }
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PickerViewController") as? PickerViewController else { fatalError("Can't load the picker") }
        vc.dataSource = self
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showVanEntry" {
            guard let vc = segue.destinationViewController as? VansEntryViewController else { return }
            vc.van = viewModel.selectedVan
        }
    }
    
    private func initialSetup() {
        enableControls(false, false, false, false)
    }
    
    private func foundOnlyVan(van: VansObject) {
        enableControls(true, true, true, true)
        
        manufacturerLabel.text = van.van.manufacturer
        modelLabel.text = van.van.model
        yearsLabel.text = van.van.yearsProduces
        editionLabel.text = van.van.edition
    }
    
    private func enableControls(model: Bool, _ years: Bool, _ edition: Bool, _ enterEnabled: Bool) {
        if viewModel.selectedVan == nil {
            modelCell.userInteractionEnabled = model
            yearsCell.userInteractionEnabled = years
            editionCell.userInteractionEnabled = edition
            
            modelLabel.enabled = model
            yearsLabel.enabled = years
            editionLabel.enabled = edition
            
            enter.enabled = enterEnabled
        }
    }
}

extension VansFilterViewController: PickerDelegate {
    func didSelectItemAtIndex(index: Int) {
        guard let safeFilter = selectedFilter else { fatalError("Oh My GUsh") }
        
        switch safeFilter {
        case .Manufacturer:
            enableControls(true, false, false, false)
            let filter = viewModel.filteredManufacturer?[index] ?? ""
            viewModel.manufacturerFilter = filter
            manufacturerLabel.text = filter
        case .Model:
            enableControls(true, true, false, false)
            let filter = viewModel.filteredModels?[index] ?? ""
            viewModel.modelFilter = filter
            modelLabel.text = filter
        case .Years:
            enableControls(true, true, true, false)
            let filter = viewModel.filteredYears?[index] ?? ""
            viewModel.yearsFilter = filter
            yearsLabel.text = filter
        case .Edition:
            enableControls(true, true, true, true)
            let filter = viewModel.filteredEdition?[index] ?? ""
            viewModel.editionFilter = filter
            editionLabel.text = filter
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
        }
    }
}