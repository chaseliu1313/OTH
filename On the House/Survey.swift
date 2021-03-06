//
//  Survey.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/26.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit


class Survey: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, PayPalPaymentDelegate {
    
    
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBOutlet weak var surveryAnswerLab: UILabel!
    
    @IBOutlet weak var surveyAnswertextfield: UITextField!
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var payPalConfig = PayPalConfiguration()
    
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
        
        var environment:String = PayPalEnvironmentNoNetwork {
            willSet(newEnvironment) {
                if (newEnvironment != environment) {
                    PayPalMobile.preconnect(withEnvironment: newEnvironment)
                }
            }
        }
        
        var payPalConfig = PayPalConfiguration()
        
        
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
    
    
    @IBAction func submit(_ sender: UIButton) {
        
        
        if self.surveyAnswertextfield.text == nil
        {
            
            self.notifyUser(["Please answer the question"])
            
        }
            
        else{
            
            ConnectionHelper.postJSON(command: command, parameter: parameter, compeletion: { (success, json) in
                
                if success
                {
                    
                    
                    print(json)
                    
                    if let paypal  =  json["paypal"].int {
                        print("paypal\(paypal)")
                        if paypal == 1 {
                            
                            print("paypal\(paypal)")
                            
                            if let name = json["item_name"].string, let p = json["item_price"].string, let email = json["paypal_email"].string, let id = json["reservation_id"].int, let sku = json["item_sku"].string {
                                
                                
                                
                                let shipping = NSDecimalNumber(string: "0.00")
                                let tax = NSDecimalNumber(string: "0.00")
                                
                                let subtotal = NSDecimalNumber(string : p)
                                
                                let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
                                let total = subtotal.adding(shipping).adding(tax)
                                
                                let payment = PayPalPayment(amount: total, currencyCode: "AUD", shortDescription: name, intent: .sale)
                                payment.paymentDetails = paymentDetails
                                
                                if (payment.processable) {
                                    let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self)
                                    self.present(paymentViewController!, animated: true, completion: nil)
                                }
                                else {
                                    // This particular payment will always be processable. If, for
                                    // example, the amount was negative or the shortDescription was
                                    // empty, this payment wouldn't be processable, and you'd want
                                    // to handle that here.
                                    print("Payment not processalbe: \(payment)")
                                }
                                //information for passing to the finish page
                                print("price\(p)")
                                self.reservation_id = String(id)
                                self.price = p
                                self.itemName = name
                                // end of information for passing to the finish page
                            }
                            
                            //duplicate infor for server error
                            if let name2 = json["item_name"].string, let p2 = json["item_price"].double, let email2 = json["paypal_email"].string, let id2 = json["reservation_id"].int, let sku2 = json["item_sku"].string {
                                
                                
                                let shipping = NSDecimalNumber(string: "0.00")
                                let tax = NSDecimalNumber(string:"0.00")
                                
                                let subtotal = NSDecimalNumber(string : String(p2))
                                
                                let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
                                let total = subtotal.adding(shipping).adding(tax)
                                
                                let payment = PayPalPayment(amount: total, currencyCode: "AUD", shortDescription: name2, intent: .sale)
                                payment.paymentDetails = paymentDetails
                                
                                if (payment.processable) {
                                    let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self)
                                    self.present(paymentViewController!, animated: true, completion: nil)
                                }
                                else {
                                    // This particular payment will always be processable. If, for
                                    // example, the amount was negative or the shortDescription was
                                    // empty, this payment wouldn't be processable, and you'd want
                                    // to handle that here.
                                    print("Payment not processalbe: \(payment)")
                                }
                                
                                
                                //information for passing to the finish page
                                self.reservation_id = String(id2)
                                self.price = String(p2)
                                self.itemName = name2
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
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        //resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            self.performSegue(withIdentifier: "finish2", sender: self)
            //self.resultText = completedPayment.description
            //self.showSuccess()
        })
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
