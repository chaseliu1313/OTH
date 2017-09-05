//
//  PreferenceViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 8/29/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var updateButton: UIButton!
    
    var command = "api/v1/memnber/"
    var member_id = "default"
   
    
    @IBOutlet weak var nikenameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var StreetTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    
    var categoryID = ""
    
    var parameter1 = ["nickname": "",
                     "title":"",
                     "firstname": "",
                     "last_name": "",
                     "age": "",
                     "email": "",
                     "phone": "",
                     "language_id": "16",
                     "address1": "",
                     "city": "",
                     "zone_id": "",
                     "zip": "",
                     "country_id": "13",
                     "timezone_id": "",
                     "newsletters": "1",
                     "focus_groups": "1",
                     "paid_marketing": "1",
                     "categories":""]
    
    
    var Array = ["Please select","Adult Industry","Art & Craft","Ballet","Cabaret","CD","CD (Product)","Children","Circus & Physical Theatre","Comedy","Dance","DVD (Product)","Family","Festival","Film","Health","Health and Fitness","Magic","Miscellaneous","Music","Musical","Natural Health","Networking, Seminars, Workshops","Opera","Operetta","Reiki Course","Soiree","Speaking Engagement","Sport","Studio Audience","Test","Theatre","Vaudeville","Young Adults"]

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        picker.delegate = self
        picker.dataSource = self
        
        getPlaceholder()
        
        
    }
    
    
    @IBAction func Subscribe(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            
           parameter1.updateValue("newsletters", forKey: "1")
            
        }
        else
        {
            parameter1.updateValue("newsletters", forKey: "0")
           
        }
        
    }
    
    @IBAction func FocusGroup(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            
           parameter1.updateValue("focus_groups", forKey: "1")
            
        }
        else
        {
            parameter1.updateValue("focus_groups", forKey: "0")
            
        }
        
    }
    
    
    @IBAction func Marketing(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            parameter1.updateValue("paid_marketing", forKey: "1")
           
            
        }
        else
        {
            parameter1.updateValue("paid_marketing", forKey: "0")
           
        }
        
    }
    

   
    func dismissKeyboard() {
       
        view.endEditing(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
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
        
        categoryID = System.getCategories(category: Array[row])
        
        
        
    }
    
    
    
    func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
   
    @IBAction func updateProfile(_ sender: UIButton) {
        
        member_id = UserDefaults.standard.string(forKey: "member_id")!
        
        if nikenameTextField.text != ""
        && titleTextField.text != ""
        && firstNameTextField.text != ""
        && lastNameTextField.text != ""
        && emailTextField.text != ""
        && StreetTextField.text != ""
        && CityTextField.text != ""
        && stateTextField.text != ""
            && postcodeTextField.text != ""
        {
        
        
        }
        
        
        
        
    }
    
    func getPlaceholder(){
    
    
        if UserDefaults.standard.string(forKey: "member_id") != nil {
        
        nikenameTextField.placeholder = UserDefaults.standard.string(forKey: "nickname")
        firstNameTextField.placeholder = UserDefaults.standard.string(forKey: "first_name")
        lastNameTextField.placeholder = UserDefaults.standard.string(forKey: "last_name")
        emailTextField.placeholder = UserDefaults.standard.string(forKey: "email")
        
        let state = System.getKey(id: Int(UserDefaults.standard.string(forKey: "zone_id")!)!, dic: System.states)
        stateTextField.placeholder = state
            
        
        }
        
    
    }
    
    
    
}
