//
//  CarsEntryViewController.swift
//  Pine Finders
//
//  Created by Haik Ampardjian on 5/28/16.
//  Copyright © 2016 Aztech Films. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CarsEntryViewController: UITableViewController {
    let viewModel = CarEntryViewModel()
    var car: CarsObject?
    
    @IBOutlet weak var entranceHeight: SkyFloatingLabelTextField!
    @IBOutlet weak var entranceWidth: SkyFloatingLabelTextField!
    @IBOutlet weak var internalHeight: SkyFloatingLabelTextField!
    @IBOutlet weak var internalWidth: SkyFloatingLabelTextField!
    @IBOutlet weak var seatUp: SkyFloatingLabelTextField!
    @IBOutlet weak var backSeatUp: SkyFloatingLabelTextField!
    @IBOutlet weak var middleSeatUp: SkyFloatingLabelTextField!
    
    @IBAction func save(_: UIBarButtonItem) {
        viewModel.save(car!,
                       input1: entranceHeight.text ?? "",
                       input2: entranceWidth.text ?? "",
                       input3: internalHeight.text ?? "",
                       input4: internalWidth.text ?? "",
                       input5: seatUp.text ?? "",
                       input6: backSeatUp.text ?? "",
                       input7: middleSeatUp.text ?? ""
        ) { success in
            dispatch_async(dispatch_get_main_queue(), { 
                if success {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Network error, try again later", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
    }
}

extension CarsEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == entranceHeight {
            return entranceWidth.becomeFirstResponder()
        }
        else if textField == entranceWidth {
            return internalHeight.becomeFirstResponder()
        }
        else if textField == internalHeight {
            return internalWidth.becomeFirstResponder()
        }
        else if textField == internalWidth {
            return seatUp.becomeFirstResponder()
        }
        else if textField == seatUp {
            return backSeatUp.becomeFirstResponder()
        }
        else if textField == backSeatUp {
            return middleSeatUp.becomeFirstResponder()
        }
        else {
            return textField.resignFirstResponder()
        }
    }
}