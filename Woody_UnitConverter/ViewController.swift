//
//  ViewController.swift
//  Woody_UnitConverter
//
//  Created by Josh Woody on 2/6/18.
//  Copyright © 2018 University of Cincinnati. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitNames.object(at: row) as? String
    }
    
    var units: NSDictionary!
    var unitNames: NSArray!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var pickerUnitFrom: UIPickerView!
    @IBOutlet weak var pickerUnitTo: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. get reference to app bundle
        let appBundle = Bundle.main
        // 2. get reference to units file path
        let filePath = appBundle.path(forResource: "units", ofType: "plist")!
        //3. load file into the units dictionary object
        units = NSDictionary(contentsOfFile: filePath)!
        //4. retrieve unit names (keys) into unitNames array object
        unitNames = units.allKeys as NSArray
        unitNames = unitNames.sorted(by: sortUnitNames) as NSArray!
    }
    
    @IBAction func userClickedConvert() {
        convert()
    }
    
    func convert(){
        //1. retireve amount from text field
        let amountAsText = txtAmount.text!
        let numberFormatter = NumberFormatter()
        let amountAsNumber = numberFormatter.number(from: amountAsText)!
        let amount = amountAsNumber.floatValue
        //2. retrieve the unit that the user selected to convert from
        let indexOfUnitToConvertFrom = pickerUnitFrom.selectedRow(inComponent: 0)
        let unitNameToConvertFrom = unitNames.object(at: indexOfUnitToConvertFrom) as? String
        let conversionFactorToInch = units.value(forKey: unitNameToConvertFrom!) as! Float
        //3. convert the amount to inches (first step in the two step conversion)
        let amountAsInches = amount * conversionFactorToInch
        //4. retrieve the unit tha the user selected to convert to
        let indexOfUnitToConvertTo = pickerUnitTo.selectedRow(inComponent: 0)
        let unitNameToConvertTo = unitNames.object(at: indexOfUnitToConvertTo) as? String
        let conversionFactorFromInch = units.value(forKey: unitNameToConvertTo!) as! Float
        let result = amountAsInches / conversionFactorFromInch
        //5. construct the result message
        let resultAsString = String.localizedStringWithFormat("%.6f %@ = %.6f %@", amount, unitNameToConvertFrom!, result, unitNameToConvertTo!)
        
        lblResult.text = resultAsString
        //6.  dismiss the keyboard
        txtAmount.resignFirstResponder()
        
    }
    
    func sortUnitNames(first: Any, second:Any) -> Bool{
        let firstName = first as! String
        let secondName = second as! String
        
        //return firstName > secondName
        
        let convFactor1 = units.value(forKey: firstName) as! Float
        let convFactor2 = units.value(forKey: secondName) as! Float
        
        return convFactor1 < convFactor2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

