//
//  FacebookRegisterView.swift
//  On the House
//
//  Created by Geng Xu on 8/23/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import Foundation
import UIKit
class FacebookRegisterView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var placementAnswer = 0
    
    @IBOutlet weak var pickview: UIPickerView!
    
    @IBOutlet weak var answerlabel: UILabel!

    @IBOutlet weak var answertextfield: UITextField!
    
    var Array = ["Please select option","If Google search, what did you search for?","Friend","If newslettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickview.delegate = self
        pickview.dataSource = self
        answerlabel.isHidden = true
        answertextfield.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        answertextfield.resignFirstResponder()
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            return Array.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return Array[row]
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        
        if(placementAnswer == 1)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else if(placementAnswer == 3)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else if(placementAnswer == 8)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else
        {
            answerlabel.isHidden = true
            answertextfield.isHidden = true
        }
    }
}
