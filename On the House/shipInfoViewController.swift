//
//  shipInfoViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/25/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

let shippingNotificationKey = "key.shippingInfo"

class shipInfoViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var pickview: UIPickerView!
    
    var placementAnswer = 0
    
    var questionid = String()
    var qty = ""
    var member_id = ""
    var show_id = ""
    
    let key = Notification.Name(rawValue: competitionNotificationKey)
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    @IBOutlet weak var answerlabel: UILabel!
    
    @IBOutlet weak var answertextfield: UITextField!
    
    var Array = ["Ticketek/TicketMaster/Moshtix", "Flyer", "Cafe", "Word of Mouth", "If Google Search, What did you search for?", "Wich website?", "Twitter", "Facebook", "Provide details of how you heard of this show?", "www.itsonthehouse.com.au", "ON THE HOUSE Newsletter", "Another Newsletter"]
    
    var data: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickview.delegate = self
        pickview.dataSource = self
        answerlabel.isHidden = true
        answertextfield.isHidden = true
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

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid = System.getQuestion(question: Array[placementAnswer])
        
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

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        print(self.data["member_id"])
    }
    
    
    
    func updateValue(notification: NSNotification){
        
        guard let memberID = notification.userInfo?["member_id"] as? String, let showID = notification.userInfo?["show_id"] as? String, let qty = notification.userInfo?["qty"] as? String else {
            return
        }
        
        self.member_id = memberID
        self.show_id = showID
        self.qty = qty
        print("\(self.member_id) + \(self.show_id) + \(self.qty)")
       
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateValue(notification:)), name: key, object: nil)
        
    }
}
