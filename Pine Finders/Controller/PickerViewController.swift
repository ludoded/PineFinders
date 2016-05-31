//
//  PickerViewController.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/25/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import UIKit

protocol PickerDelegate {
    func didSelectItemAtIndex(index: Int)
}

protocol PickerDataSource {
    func numberOfItems() -> Int
    func itemTitleForIndex(index: Int) -> String
}

class PickerViewController: UIViewController {
    var delegate: PickerDelegate?
    var dataSource: PickerDataSource?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @objc func save(_: UIBarButtonItem) {
        delegate?.didSelectItemAtIndex(pickerView.selectedRowInComponent(0))
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(save(_:)))
        navigationItem.rightBarButtonItem = save
    }
}

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel()
        label.backgroundColor = .clearColor()
        label.textColor = .blackColor()
        label.text = dataSource?.itemTitleForIndex(row)
        label.font = UIFont.systemFontOfSize(17)
        label.minimumScaleFactor = 0.5
        label.sizeToFit()
        
        return label
    }
}

extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.numberOfItems() ?? 0
    }
}