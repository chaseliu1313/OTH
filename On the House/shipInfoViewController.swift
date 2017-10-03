//
//  shipInfoViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/25/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit



class shipInfoViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var pickview: UIPickerView!
    
    @IBOutlet weak var state: UIPickerView!
    
    var placementAnswer = 0
    
    var questionid = String()
    var qty = ""
    var member_id = ""
    var show_id = ""
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    
    var parameter : [String: String] = [:]

    
    @IBOutlet weak var answerlabel: UILabel!
    
    @IBOutlet weak var answertextfield: UITextField!
    
    var Array = ["Ticketek/TicketMaster/Moshtix", "Flyer", "Cafe", "Word of Mouth", "If Google Search, What did you search for?", "Wich website?", "Twitter", "Facebook", "Provide details of how you heard of this show?", "www.itsonthehouse.com.au", "ON THE HOUSE Newsletter", "Another Newsletter"]
    
    var Array2 = ["Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia"]
    
    var data: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickview.delegate = self
        pickview.dataSource = self
        answerlabel.isHidden = true
        answertextfield.isHidden = true
        state.delegate = self
        state.dataSource = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var rows = 0
        
        if pickview == pickerView{
            rows =  Array.count
        }
            
        else if state == pickerView {
            
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
            return Array[row]
        } else if state == pickerView{
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
            pickerLabel?.text = Array[row]
        }
            
        else if state == pickerView {
            
            pickerLabel?.text = Array2[row]
            
            print("\(row)+\(String(describing: pickerLabel?.text!))")
        }
        
        return pickerLabel!;
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid = System.getQuestion(question: Array[placementAnswer])
        if pickview == pickerView {
        if(placementAnswer == 4)
        {
            answerlabel.isHidden = false
            answertextfield.isHidden = false
        }
        else if(placementAnswer == 5)
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

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        
    }
    
    
    
   
}
