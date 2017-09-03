//
//  InfoCollectionViewController.swift
//  On the House
//
//  Created by 吃面包的布拉德 on 2017/8/25.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class InfoCollectionViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var statepickerview: UIPickerView!
    
    @IBOutlet weak var nicknametextfield: UITextField!
    @IBOutlet weak var firstnametextfield: UITextField!
    @IBOutlet weak var lastnametextfield: UITextField!
    @IBOutlet weak var postcodetextfield: UITextField!
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    @IBOutlet weak var reenterpasswordtextfield: UITextField!
    
    
    
    var Array = ["Please Select", "Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia"]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        
        return false
    }
    
    func datapreparation() {
        if let nickname = nicknametextfield.text{ NewMemberData.nickname = nickname.trimmingCharacters(in: CharacterSet.whitespaces) }
        if let firstname = firstnametextfield.text{ NewMemberData.first_name = firstname.trimmingCharacters(in: CharacterSet.whitespaces) }
        if let lastname = lastnametextfield.text{ NewMemberData.last_name = lastname.trimmingCharacters(in: CharacterSet.whitespaces) }
        if let password = passwordtextfield.text { NewMemberData.password = password.trimmingCharacters(in: CharacterSet.whitespaces) }
        if let passwordconfirm = reenterpasswordtextfield.text {
            NewMemberData.password_confirm = passwordconfirm.trimmingCharacters(in: CharacterSet.whitespaces)}
        if let email = emailtextfield.text{
            NewMemberData.email = email.trimmingCharacters(in: CharacterSet.whitespaces)}
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        statepickerview.delegate = self
        statepickerview.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel!.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel!.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = Array[row]
        
        return pickerLabel!;
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknametextfield.resignFirstResponder()
        firstnametextfield.resignFirstResponder()
        lastnametextfield.resignFirstResponder()
        statepickerview.resignFirstResponder()
        postcodetextfield.resignFirstResponder()
        emailtextfield.resignFirstResponder()
        passwordtextfield.resignFirstResponder()
        reenterpasswordtextfield.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


