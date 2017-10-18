//
//  shipInfoViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/25/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit


class shipInfoViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource, PayPalPaymentDelegate{
    
    let tokenizationkey = "sandbox_b7kvdchs_9py4y9wtg3mjcv8g"
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var payPalConfig = PayPalConfiguration()
    
    @IBOutlet weak var pickview: UIPickerView!
    
    @IBOutlet weak var state: UIPickerView!
    
    var placementAnswer = 0
    var questionText = ""
    var questionid = String()
    var qty = ""
    var member_id = ""
    var show_id = ""
    let command = "api/v1/reserve"
    
    var urladdress  = ""
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var postcode: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    var save = ""
    var zoneID = ""
    
       //passing to the finish screen
    var reservation_id = " "
    var price = " "
    var itemName = " "
    var sku = " "
    
    @IBAction func saveSwitch(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            save = "1"
            
            
        }
        else
        {
            save = "0"
            
        }
        
    }
    
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

    var complet : [String: String] = ["nonce": "",
                                      "reservatiion_id": "",
                                      "show_id": "",
                                      "member_id": "",
                                      "price": "",
                                      "tickets": "3"
                                      ]
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
       
        self.show_id =  self.data["show_id"]!
        self.member_id = self.data["member_id"]!
        self.qty = self.data["qty"]!
        

        
        self.parameter.updateValue(self.show_id, forKey: "show_id")
        self.parameter.updateValue(self.member_id, forKey: "member_id")
        self.parameter.updateValue(self.qty, forKey: "tickets")
        
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "On-The-House, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        // Do any additional setup after loading the view, typically from a nib.
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        payPalConfig.payPalShippingAddressOption = .both
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
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
            
        }
        
        return pickerLabel!;
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid = System.getQuestion(question: Array[placementAnswer])
        self.parameter.updateValue(questionid, forKey: "question_id")
        self.parameter.updateValue(Array[row], forKey: "question_text")
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
        else {
        
        self.zoneID = System.setState(state: Array2[row])
        self.parameter.updateValue(self.zoneID, forKey: "shipping_zone")
        
        }
    }

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        //self.customPayPalButtonTapped(amount: 5)
        
        if !self.answertextfield.isHidden
            && self.answertextfield.text == nil {
            
        self.notifyUser(["Please provide all information."])
        
        }
        
        
            
            self.parameter.updateValue(answertextfield.text!, forKey: "Answer")
        
        if self.firstName.text != nil
            && self.lastname.text != nil
            && self.address.text != nil
            && self.city.text != nil
            && self.postcode.text != nil
            && self.phoneNumber.text != nil
           
        
        {
            self.parameter.updateValue(firstName.text!, forKey: "shipping_first_name")
            self.parameter.updateValue(lastname.text!, forKey: "shipping_last_name")
            self.parameter.updateValue(address.text!, forKey: "shipping_address1")
            self.parameter.updateValue(city.text!, forKey: "shipping_city")
            self.parameter.updateValue(postcode.text!, forKey: "shipping_zip")
            self.parameter.updateValue(phoneNumber.text!, forKey: "shipping_phone")
            self.parameter.updateValue(save, forKey: "shipping_save_info")
            
        ConnectionHelper.postJSON(command: command, parameter: parameter, compeletion: { (success, json) in
            if success {
                
                print(json)
                if let paypal  =  json["paypal"].int{
                    print("paypal\(paypal)")
                    
                    if paypal == 1 {
                        print("paypal\(paypal)")
                        //information for paypal checkout
                        if let name = json["item_name"].string, let p = json["item_price"].double, let email = json["paypal_email"].string, let id = json["reservation_id"].int, let sku = json["item_sku"].string {
                            
                            
                            let shipping = NSDecimalNumber(string: "0.00")
                            let tax = NSDecimalNumber(string:"0.00")
                            
                            let subtotal = NSDecimalNumber(string : String(p))
                            
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
                            self.reservation_id = String(id)
                            self.price = String(p)
                            self.itemName = name
                            // end of information for passing to the finish page
                            
                        }
                        
                        
                        
                    }
                    else
                    {
                        
                        
                        
                        
                    }
                    
                }
                
                if let redirectLink = json["affiliate_url"].string {
                    
                    self.performSegue(withIdentifier: "redirect1", sender: self)
                    
                    
                    
                }
                
                
            
                
                
            
            }
            
            else {
            
                let error = json["error"]["messages"].arrayObject as! [String]
                self.notifyUser(error)
            }
        })
            
            
        
        }
        
        else{
        
            self.notifyUser(["Please provide all information."])
        
        }
        
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
            self.performSegue(withIdentifier: "finish1", sender: self)
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
            
            vc?.address = self.urladdress
            
        }
        
    }
   
}
