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
    
    var command = "api/v1/member/"
    var member_id = ""
   
    
    @IBOutlet weak var nikenameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var StreetTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var statePickerView: UIPickerView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    
    var categoryID = ""
    var stateID = ""
    
    var parameter1 :[String: Any] = ["nickname": "",
                     "title":"",
                     "first_name": "",
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
    
    @IBAction func `return`(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var Array = ["Adult Industry","Art & Craft","Ballet","Cabaret","CD (Product)","Children","Circus & Physical Theatre","Comedy","Dance","DVD (Product)","Family","Festival","Film","Health and Fitness","Magic","Miscellaneous","Music","Musical","Networking, Seminars, Workshops","Opera","Operetta","Reiki Course","Soiree","Speaking Engagement","Sport","Studio Audience","Theatre","Vaudeville"]

    var Array2 = ["New South Wales" , "Northern Territory" , "Queensland" , "South Australia", "Tasmania", "Victoria", "Western Australia", "Australian Capital Territory"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        statePickerView.delegate = self
        statePickerView.dataSource = self

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
        
        if picker == pickerView {
            return Array.count
        } else if statePickerView == pickerView{
            return Array2.count
        }
      return 1
       
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel!.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel!.textAlignment = NSTextAlignment.center
        }
        
        if picker == pickerView{
            pickerLabel?.text = Array[row]
        }
            
        else if statePickerView == pickerView{
            pickerLabel?.text = Array2[row]
        }
        
        return pickerLabel!;
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if picker == pickerView {
            return Array[row]
        } else if statePickerView == pickerView{
            return Array2[row]
        }
        return ""
    }
   
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if picker == pickerView{
            self.categoryID = System.getCategories(category: Array[row])
        }
            
        else if statePickerView == pickerView{
            self.stateID = System.setState(state: Array2[row])
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
   
    @IBAction func updateProfile(_ sender: UIButton) {
        
        
        
        
        member_id = UserDefaults.standard.string(forKey: "member_id")!
        
        self.setEmail()
        self.setFirstName()
        self.setLastName()
        self.setNickname()
        self.setZip()
        
        if
         titleTextField.text != ""
        && StreetTextField.text != ""
        && CityTextField.text != ""
        && ageTextField.text != ""
        && phoneTextField.text != ""
        
        {
            self.parameter1.updateValue(titleTextField.text!, forKey: "title")
            self.parameter1.updateValue(StreetTextField.text!, forKey: "address1")
            self.parameter1.updateValue(CityTextField.text!, forKey: "city")
            self.parameter1.updateValue(ageTextField.text!, forKey: "age")
            self.parameter1.updateValue(phoneTextField.text!, forKey: "phone")
            self.parameter1.updateValue(self.categoryID, forKey: "categories")
            self.parameter1.updateValue(self.stateID, forKey: "zone_id")
            let timezone_id = System.getTimezone()
            self.parameter1.updateValue(timezone_id, forKey: "timezone_id")
        
            if member_id != ""{
                
                let url = command + member_id
                
                ConnectionHelper.post(command: url, parameter: parameter1, compeletion: { (success,msg) in
                    
                    if success {
                        UserDefaults.standard.set(self.nikenameTextField.text!, forKey: "nickname")
                    
                        UserDefaults.standard.set(self.firstNameTextField.text!, forKey: "first_name")
                       UserDefaults.standard.set(self.lastNameTextField.text!, forKey: "last_name")
                        
                        UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                        
                        UserDefaults.standard.set(self.titleTextField.text!, forKey: "title")
                        UserDefaults.standard.set(self.ageTextField.text!, forKey: "age")
                        UserDefaults.standard.set(self.phoneTextField.text!, forKey: "phone")
                        UserDefaults.standard.set(self.StreetTextField.text!, forKey: "address1")
                        UserDefaults.standard.set(self.stateID, forKey: "zone_id")
                        UserDefaults.standard.set(self.CityTextField.text!, forKey: "address1")
                       UserDefaults.standard.set(self.postcodeTextField.text!, forKey: "zip")
                        
                        UserDefaults.standard.set(timezone_id, forKey: "timezone_id")
                        self.notifyUser(msg)
                        
                    }
                    else{
                       self.notifyUser(msg)
                    }
                })
            
            
            }
            else {
            
                self.notifyUser(["ERROR: Invalid Member Information, Please Login Again"])
            }
            
            
            
        }
        
        else {
        
        self.notifyUser(["Please Enter ALL Fields"])
        }
        
        
    }
    
    
    //retrieve placeholders from userdefaults
    func getPlaceholder(){
    
    
        if UserDefaults.standard.string(forKey: "member_id") != nil {
        
        nikenameTextField.placeholder = UserDefaults.standard.string(forKey: "nickname")
        firstNameTextField.placeholder = UserDefaults.standard.string(forKey: "first_name")
        lastNameTextField.placeholder = UserDefaults.standard.string(forKey: "last_name")
        emailTextField.placeholder = UserDefaults.standard.string(forKey: "email")
        postcodeTextField.placeholder = UserDefaults.standard.string(forKey: "zip")
            
            
            if UserDefaults.standard.string(forKey: "title") != nil{
            
                titleTextField.placeholder =  UserDefaults.standard.string(forKey: "title")
            }
            
            if UserDefaults.standard.string(forKey: "address1") != nil{
                
                StreetTextField.placeholder =  UserDefaults.standard.string(forKey: "address1")
            }
            
            if UserDefaults.standard.string(forKey: "city") != nil{
                
                CityTextField.placeholder =  UserDefaults.standard.string(forKey: "city")
                
            }
            if UserDefaults.standard.string(forKey: "age") != nil{
                
                CityTextField.placeholder =  UserDefaults.standard.string(forKey: "age")
                
            }
            if UserDefaults.standard.string(forKey: "phone") != nil{
                
                CityTextField.placeholder =  UserDefaults.standard.string(forKey: "phone")
                
            }
            
      
        
         }
    

    }
    
    func setEmail()
    {
    
        if emailTextField.text != ""
            && emailTextField.text != UserDefaults.standard.string(forKey: "email")
        {
            parameter1.updateValue(emailTextField.text!, forKey: "email")
            UserDefaults.standard.set(emailTextField.text!, forKey: "email")
            UserDefaults.standard.synchronize()
            
        }
            
        else if emailTextField.text == "" || emailTextField.text == UserDefaults.standard.string(forKey: "email") {
            self.emailTextField.text = UserDefaults.standard.string(forKey: "email")
            parameter1.updateValue(UserDefaults.standard.string(forKey: "email")!, forKey: "email")
            
        }
        
    }
    
    func setFirstName() {
    
        if firstNameTextField.text != ""
            && firstNameTextField.text != UserDefaults.standard.string(forKey: "first_name")
        {
            parameter1.updateValue(firstNameTextField.text!, forKey: "first_name")
            UserDefaults.standard.set(firstNameTextField.text!, forKey: "first_name")
            UserDefaults.standard.synchronize()
            
        }
            
        else if firstNameTextField.text == "" || firstNameTextField.text == UserDefaults.standard.string(forKey: "first_name") {
            self.firstNameTextField.text = UserDefaults.standard.string(forKey: "first_name")
            parameter1.updateValue(UserDefaults.standard.string(forKey: "first_name")!, forKey: "first_name")
            
        }
    }
    
    
        func setLastName() {
            
            if lastNameTextField.text != ""
                && lastNameTextField.text != UserDefaults.standard.string(forKey: "last_name")
            {
                parameter1.updateValue(lastNameTextField.text!, forKey: "last_name")
                UserDefaults.standard.set(lastNameTextField.text!, forKey: "last_name")
                UserDefaults.standard.synchronize()
                
            }
                
            else if lastNameTextField.text == "" || lastNameTextField.text == UserDefaults.standard.string(forKey: "last_name") {
                self.lastNameTextField.text = UserDefaults.standard.string(forKey: "last_name")
                parameter1.updateValue(UserDefaults.standard.string(forKey: "last_name")!, forKey: "last_name")
                
            }

    
    }
    
    func setZip() {
        
        if postcodeTextField.text != ""
            && postcodeTextField.text != UserDefaults.standard.string(forKey: "zip")
        {
            parameter1.updateValue(postcodeTextField.text!, forKey: "zip")
            UserDefaults.standard.set(postcodeTextField.text!, forKey: "zip")
            UserDefaults.standard.synchronize()
            
        }
            
        else if postcodeTextField.text == "" || postcodeTextField.text == UserDefaults.standard.string(forKey: "zip") {
            
            self.postcodeTextField.text = UserDefaults.standard.string(forKey: "zip")
            parameter1.updateValue(UserDefaults.standard.string(forKey: "zip")!, forKey: "zip")
            
            
        }
        
        
    }
    
    func setNickname() {
        
        if nikenameTextField.text != ""
            && nikenameTextField.text != UserDefaults.standard.string(forKey: "nickname")
        {
            parameter1.updateValue(nikenameTextField.text!, forKey: "nickname")
            UserDefaults.standard.set(nikenameTextField.text!, forKey: "nickname")
            UserDefaults.standard.synchronize()
            
        }
            
        else if nikenameTextField.text == "" || nikenameTextField.text == UserDefaults.standard.string(forKey: "nickname") {
            
            self.nikenameTextField.text = UserDefaults.standard.string(forKey: "nickname")
            parameter1.updateValue(UserDefaults.standard.string(forKey: "nickname")!, forKey: "nickname")
            
            
        }
        
        
    }
    
}
