//
//  FacebookRegisterView.swift
//  On the House
//
//  Created by Geng Xu on 8/23/17.
//  Copyright © 2017 Zhang Zhnag. All rights reserved.
//

import Foundation
import UIKit
class FacebookRegisterView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
   
    @IBOutlet weak var statepickerview: UIPickerView!
    
    var placementAnswer = 0
    
    @IBOutlet weak var pickview: UIPickerView!
    
    @IBOutlet weak var answerlabel: UILabel!

    @IBOutlet weak var answertextfield: UITextField!
    
    var Array1 = ["Please select option","If Google search, what did you search for?","Friend","If newslettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    var Array2 = ["Please Select", "Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickview.delegate = self
        pickview.dataSource = self
        
        statepickerview.delegate = self
        statepickerview.dataSource = self
        
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
            return Array2.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            if pickview == pickerView {
                return Array1[row]
            } else if statepickerview == pickerView{
                return Array2[row]
            }
            return ""
        }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel!.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel!.textAlignment = NSTextAlignment.center
        }
        
        if pickview == pickerView{
        pickerLabel?.text = Array1[row]
        }
        
        else if statepickerview == pickerView{
            pickerLabel?.text = Array2[row]
        }
        
        
        return pickerLabel!;
    }

    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        
        if pickview==pickerView{
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
}
