//
//  Survey.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/26.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit



class Survey: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBOutlet weak var surveryAnswerLab: UILabel!
    
    @IBOutlet weak var surveyAnswertextfield: UITextField!
    
     let command = "api/v1/reserve"
    var qty = ""
    var member_id = ""
    var show_id = ""
    var data: [String: String] = [:]

    var address = ""
    
    var Array = ["If google search, what did you search for?","Friend","If newsettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    var questionid = String()
    var placementAnswer = 0
    var answer = ""
    
    
    var parameter : [String: String] = ["show_id":"",
                                        "member_id": "",
                                        "tickets": "",
                                        "shipping_first_name":"",
                                        "shipping_last_name":"",
                                        "shipping_address1": "",
                                        "shipping_city":"",
                                        "shipping_zone_id":"",
                                        "shipping_zip":"",
                                        "shipping_phone":"",
                                        "shipping_save_info": "",
                                        "question_id": "13",
                                        "question_text": "",
                                        "Answer": " "]
    
    
    //passing to the finish screen
    
    var reservation_id = " "
    var price = " "
    var itemName = " "
    var sky = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        pickView.delegate = self
        pickView.dataSource = self
        surveryAnswerLab.isHidden = true
        surveyAnswertextfield.isHidden = false
        
        if(surveyAnswertextfield.text != "")
        {
            answer = surveyAnswertextfield.text!
        }
        else
        {
            
            answer = "null"
            
        }
        
        self.show_id =  self.data["show_id"]!
        self.member_id = self.data["member_id"]!
        self.qty = self.data["qty"]!
        self.parameter.updateValue(self.show_id, forKey: "show_id")
        self.parameter.updateValue(self.member_id, forKey: "member_id")
        self.parameter.updateValue(self.qty, forKey: "tickets")


        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        
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
    
    
    @IBAction func submit(_ sender: Any) {
        
       
        
        
            if self.surveyAnswertextfield.text == nil
            {
               
                self.notifyUser(["Please answer the question"])
            
            }
            
            else{
            
                ConnectionHelper.postJSON(command: command, parameter: parameter, compeletion: { (success, json) in
                    
                    if success
                    {
                        print(json)
                        
                        if let paypal  =  json["paypal"].string {
                            
                            if json["paypal"].string == "1" {
                                
                                
                                if let name = json["item_name"].string, let p = json["item_price"].string, let email = json["paypal_email"].string, let id = json["reservation_id"].string, let sku = json["item_sku"].string {
                                    
                                    //information for passing to the finish page
                                    self.reservation_id = id
                                    self.price = p
                                    self.itemName = name
                                    // end of information for passing to the finish page
                                    
                                }
                                
                                
                            }
                            else
                            {
                                
                                
                                
                                
                            }
                            
                        }
                        
                        if let redirectLink = json["affiliate_url"].string {
                            
                          
                            self.address  = redirectLink
                            self.performSegue(withIdentifier: "redirect2", sender: self)
                            
                            
                        }
                        
                        
                    }
                    else {
                        
                        let error = json["error"]["messages"].arrayObject as! [String]
                        self.notifyUser(error)
                    }
                    
                })
                
            
            }
            
            
        
        
        
        
        self.parameter.updateValue(surveyAnswertextfield.text!, forKey: "Answer")
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid = System.getQuestion(question: Array[placementAnswer])
        self.parameter.updateValue(questionid, forKey: "question_id")
        self.parameter.updateValue(Array[row], forKey: "question_text")
        
         if pickView==pickerView{
        if(placementAnswer == 0)
        {
            surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else if(placementAnswer == 2)
        {
           surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else if(placementAnswer == 7)
        {
            surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else
        {
            surveryAnswerLab.isHidden = true
            surveyAnswertextfield.isHidden = true
        }
        }
    }

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func notifyUser( _ message: [String] ) -> Void
    {
        
        var meg = ""
        
        for error in message {
            
            meg.append("\n \(error)")
            
        }
        
        
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is FinishReservViewController {
            
            let vc = segue.destination as? FinishReservViewController
            vc?.reservation_id = self.reservation_id
            vc?.show_id  = self.show_id
            vc?.member_id = self.member_id
            vc?.price = self.price
            vc?.tickets = self.qty
            
        }
        else if segue.destination is RedirectViewController {
            
            let vc = segue.destination as? RedirectViewController
                
                vc?.address = self.address
                
            
            
        }
        
    }
   
}
