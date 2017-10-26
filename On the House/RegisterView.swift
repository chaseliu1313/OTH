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
    
    @IBOutlet weak var notification: UILabel!
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
    
    var loginParameter = [
        "email": " ",
        "password": " "
    ]
    let loginCommand =  "api/v1/member/login"
    
    var nickname = String()
    var first_name = String()
    var last_name = String()
    var zip = String()
    var zone_id = String()
    let country_id = "13"
    var time_zone = System.getTimezone()
    var email = String()
    var password = String()
    var password_confirm = String()
    
    var questionid = String()
    var placementAnswer = 0
    @IBOutlet weak var answerlabel: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var answertextfield: UITextField!
    var answer = ""
    
    @IBOutlet weak var Switch: UISwitch!
    
    var term = ""
    
    @IBOutlet weak var signup: UIButton!
    
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            term = "1"
            signup.isHidden = false
            
        }
        else
        {
            term = "0"
            signup.isHidden = true
        }
    }
    
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var Array = ["If google search, what did you search for?","Friend","If newsettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    
    @IBAction func SignUP(_ sender: UIButton) {
        
        
        ConnectionHelper.post(command: command, parameter: parameter) { (successed,msg) in
            if(successed) {
                
                
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                
                self.notification.text = "You are all set! Auto-login now."
                
                
                ConnectionHelper.userLogin(command: self.loginCommand, parameter: self.loginParameter, compeletion: { (success1) in
                    
                    if success1 {
                        
                        self.performSegue(withIdentifier: "successfullyreg", sender: self)
                        
                    }
                    
                })
        
                
                
                
                
                
                
                
            }
            else{
                
                
                self.notifyUser(msg)
                
            }
        }
        
        self.notification.text = " "
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        pickerview.delegate = self
        pickerview.dataSource = self
        answerlabel.isHidden = true
        answertextfield.isHidden = false
        signup.isHidden = false
        
        if(answertextfield.text != "")
        {
            answer = answertextfield.text!
        }
        else
        {
            
            answer = "null"
            
        }
        
        parameter.updateValue(nickname, forKey: "nickname")
        parameter.updateValue(first_name, forKey: "first_name")
        parameter.updateValue(last_name, forKey: "last_name")
        parameter.updateValue(zip, forKey: "zip")
        parameter.updateValue(zone_id, forKey: "zone_id")
        parameter.updateValue(time_zone, forKey: "timezone_id")
        parameter.updateValue(questionid, forKey: "question_id")
        parameter.updateValue(answer, forKey: "question_text")
        parameter.updateValue(email, forKey: "email")
        parameter.updateValue(password, forKey: "password")
        parameter.updateValue(password_confirm, forKey: "password_confirm")
        
        
        loginParameter.updateValue(password, forKey: "password")
        loginParameter.updateValue(email, forKey: "email")
        
    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        answertextfield.resignFirstResponder()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
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
        questionid = System.getQuestion(question: Array[placementAnswer])
        
        if(placementAnswer == 0)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else if(placementAnswer == 2)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else if(placementAnswer == 7)
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
    
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
}
