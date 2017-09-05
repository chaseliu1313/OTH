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
    
    let command = "api/v1/member/create"
    
    var parameter = ["nickname": "",
                     "firstname": "",
                     "last_name": "",
                     "zip": "",
                     "zone_id": "",
                     "country_id": "13",
                     "timezone_id": "",
                     "question_id": "",
                     "question_text":"null",
                     "email": "",
                     "password":"",
                     "password_confirm": "",
                     "terms": "1"]
    
    var questionid = String()
    
    @IBOutlet weak var reentertextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    @IBOutlet weak var nicknametextfield: UITextField!
    
    @IBOutlet weak var statepickerview: UIPickerView!
    
    @IBOutlet weak var postcodetextfield: UITextField!
    
    var placementAnswer = 0
    
    @IBOutlet weak var pickview: UIPickerView!
    
    @IBOutlet weak var answerlabel: UILabel!
    
    @IBOutlet weak var answertextfield: UITextField!
    
    func dataprepare(){
        if let nickname = nicknametextfield!.text{
            NewMemberData.nickname = nickname
        }
        if let password = passwordtextfield!.text{
            NewMemberData.password = password
        }
        if let reenter = reentertextfield!.text{
            NewMemberData.password_confirm = reenter
        }
        if let postcode = postcodetextfield!.text{
            NewMemberData.zip = postcode
        }
        if let state = statepickerview?.selectedRow(inComponent: 0).description{
            NewMemberData.zone_id = state
        }
        if let questionid = pickview?.selectedRow(inComponent: 0).description{
            NewMemberData.question_id = questionid
        }
        if let answer = answerlabel!.text{
            NewMemberData.question_text = answer
        }
    }
    
    var Array1 = ["Please select option","If Google search, what did you search for?","Friend","If newslettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    var Array2 = ["Please Select", "Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statepickerview.delegate = self
        statepickerview.dataSource = self
        
        pickview.delegate = self
        pickview.dataSource = self
        
        
        answerlabel.isHidden = true
        answertextfield.isHidden = true
        
        //dataprepare()
        
        parameter.updateValue(NewMemberData.nickname, forKey: "nickname")
        parameter.updateValue(NewMemberData.first_name, forKey: "first_namne")
        parameter.updateValue(NewMemberData.last_name, forKey: "last_name")
        parameter.updateValue(NewMemberData.zip, forKey: "zip")
        parameter.updateValue(NewMemberData.zone_id, forKey: "zone_id")
        parameter.updateValue(NewMemberData.timezone_id, forKey: "timezone_id")
        parameter.updateValue(NewMemberData.question_id, forKey: "question_id")
        parameter.updateValue(NewMemberData.question_text, forKey: "question_text")
        parameter.updateValue(NewMemberData.email, forKey: "email")
        parameter.updateValue(NewMemberData.password, forKey: "password")
        parameter.updateValue(NewMemberData.password_confirm, forKey: "password_confirm")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Signup(_ sender: UIButton) {
        dataprepare()
        ConnectionHelper.post(command: command, parameter: parameter) { (successed) in
            if(successed) {
                
                
                self.notifyUser("ON THE HOUSE", "Registration Successfull")
                
            }
            else{
                
                
                self.notifyUser("ON THE HOUSE", "Something IS Wrong")
                
            }
        }
    }
    
    func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
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
