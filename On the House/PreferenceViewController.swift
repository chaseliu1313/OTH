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
    
    var url = "api/v1/memnber/"
    let member_id = UserDefaults.standard.object(forKey: "member_id")
    let command = ""
    
    
    
    
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
                     "newsletters": "",
                     "focus_groups": "",
                     "paid_marketing": "",
                     "categories":""]
    
    
    
    
    
    var switch1 = ""
    var switch2 = ""
    var switch3 = ""
    
    
    @IBAction func Subscribe(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            switch1 = "1"
            updateButton.isHidden = false
            
        }
        else
        {
            switch1 = "0"
            updateButton.isHidden = true
        }
        
    }
    
    @IBAction func FocusGroup(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            switch2 = "1"
            updateButton.isHidden = false
            
        }
        else
        {
            switch2 = "0"
            updateButton.isHidden = true
        }
        
    }
    
    
    @IBAction func Marketing(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            switch3 = "1"
            updateButton.isHidden = false
            
        }
        else
        {
            switch3 = "0"
            updateButton.isHidden = true
        }
        
    }
    var Array = ["Please select","Adult Industry","Art & Craft","Ballet","Cabaret","CD","CD (Product)","Children","Circus & Physical Theatre","Comedy","Dance","DVD (Product)","Family","Festival","Film","Health","Health and Fitness","Magic","Miscellaneous","Music","Musical","Natural Health","Networking, Seminars, Workshops","Opera","Operetta","Reiki Course","Soiree","Speaking Engagement","Sport","Studio Audience","Test","Theatre","Vaudeville","Young Adults"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
