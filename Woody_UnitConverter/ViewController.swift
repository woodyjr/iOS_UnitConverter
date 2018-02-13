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

