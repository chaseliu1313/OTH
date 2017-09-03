//
//  RegisterView.swift
//  On the House
//
//  Created by Zhang Zhang on 8/23/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import Foundation
import UIKit
class RegisterView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let command = "api/v1/member/create"
    let parameter = ["nickname": "",
                     "firstname": "",
                     "last_name": "",
                      "zip": "",
                      "zone_id": "",
                      "country_id": "13",
                      "timezone_id": "",
                      "question_id": "",
                      "question_text":"",
                      "email": "",
                      "password":"",
                      "password_confirm": "",
                      "terms": ""]
    
    var nickname = ""
    var first_name = ""
    var last_name = ""
    var zip = ""
    var zone_id = ""
    let country_id = "13"
    var time_zone = System.getTimezone()
    var email = ""
    var password = ""
    var password_confirm = ""

    
    @IBAction func SignUP(_ sender: UIButton) {
        
        
        ConnectionHelper.userLogin(command: command, parameter: parameter) { (successed) in
            if(successed) {
            }
            else{
            
            }
        }
        
    }
    
    
    var placementAnswer = 0
    @IBOutlet weak var answerlabel: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    var Array = ["Please select option","If google search, what did you search for?","Friend","If newsettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    @IBOutlet weak var answertextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        pickerview.delegate = self
        pickerview.dataSource = self
        answerlabel.isHidden = true
        answertextfield.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
