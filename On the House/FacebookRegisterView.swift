//
//  FacebookRegisterView.swift
//  On the House
//
//  Created by Geng Xu on 8/23/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FacebookRegisterView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    let command = "api/v1/member/create"
    
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
        if let nickname = nicknametextfield.text{
            NewMemberData.nickname = nickname
        }
        if let password = passwordtextfield.text{
            NewMemberData.password = password
        }
        if let reenter = reentertextfield.text{
            NewMemberData.password_confirm = reenter
        }
        if let postcode = postcodetextfield.text{
            NewMemberData.zip = postcode
        }
        if let state = statepickerview?.selectedRow(inComponent: 0).description{
            NewMemberData.zone_id = state
        }
        
        NewMemberData.question_id = questionid
        
        if let answer = answerlabel.text{
            NewMemberData.question_text = answer
        }
        
        NewMemberData.timezone_id = System.getTimezone()
    }
    var Array1 = ["If Google search, what did you search for?","Friend","If newslettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    
    var Array2 = ["Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        statepickerview.delegate = self
        statepickerview.dataSource = self
        
        pickview.delegate = self
        pickview.dataSource = self
        
        
        
        answerlabel.isHidden = true
        answertextfield.isHidden = false
        signup.isHidden = false
        
        dataprepare()
        
        // Do any additional setup after loading the view.
    }
    
    private func updateDatabase(with email: String) {
        print("starting database load")
        container?.performBackgroundTask { [weak self] context in
            _ = try? FacebookUser.findorcreatuser(matching: email, in: context)
            try? context.save()
            print("done loading database")
        }
    }
    
    private func findfbuser(with email: String) -> Bool {
        var result = false
        container?.performBackgroundTask { [weak self] context in
            result = FacebookUser.checkuser(matching: email, in: context)
        }
        return result
    }
    
    @IBAction func Signup(_ sender: UIButton) {
        dataprepare()
        ConnectionHelper.post(command: command, parameter: NewMemberData.getinformation()) { (successed,msg) in
            if(successed) {
                
                self.notifyUser(["Registration Successfull"])
                if !self.findfbuser(with: NewMemberData.email){
                    self.updateDatabase(with: NewMemberData.email)
                }
                self.performSegue(withIdentifier: "facebooksignup", sender: self)
            }
            else{
                self.notifyUser(msg)
                
            }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        answertextfield.resignFirstResponder()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var rows = 0
        
        if pickview == pickerView {
        rows = Array1.count
        }
        else  {
        
        rows = Array2.count
        }
        
        return rows
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

    @IBOutlet weak var signup: UIButton!
    
    @IBAction func `switch`(_ sender: UISwitch) {
            if(sender.isOn == true)
            {
                
                signup.isHidden = false
                
            }
            else
            {
                
                signup.isHidden = true
            }
        }

    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid =  System.getQuestion(question: Array1[placementAnswer])
        
        if pickview==pickerView{
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
    }
}
