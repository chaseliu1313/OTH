//
//  ViewController.swift
//
//
//  Created by Santosh on 17/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit
import BEMCheckBox
import SwiftyJSON

class MemHisViewController: UIViewController {

    let infoAlert = AlertDisplay()
    let myDispatchGroup = DispatchGroup()
    var apiHandler = NetworkService()
    
    var memHistResponseData:[String:JSON] = [:]
    var memInfoResponseData:[String:JSON] = [:]
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var memHistTableView: UITableView!
    @IBOutlet weak var goldMemTitle: UILabel!
    @IBOutlet weak var bronzeMemTitle: UILabel!
    
    @IBOutlet weak var goldOption: BEMCheckBox!
    @IBOutlet weak var bronzeOption: BEMCheckBox!
    
    @IBOutlet weak var goldMemInfo: UILabel!
    @IBOutlet weak var bronzeMemInfo: UILabel!
    
    var checkBoxGroup = BEMCheckBoxGroup()
    var initialCheckBoxSelected = BEMCheckBox()
    var currentMembership: String = ""

    var memPostParameters:[String:String] = [:]
    
    var payPalConfig = PayPalConfiguration()
    var paypalTransactionSuccessful = false
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    func connectTableViewToService() {
        memHistTableView.delegate = self
        memHistTableView.dataSource = self
    }
    
    func configureCheckBoxGroup(checkBoxSelected: BEMCheckBox) {
        self.checkBoxGroup.addCheckBox(toGroup: goldOption)
        self.checkBoxGroup.addCheckBox(toGroup: bronzeOption)
        self.checkBoxGroup.selectedCheckBox = self.initialCheckBoxSelected
        self.checkBoxGroup.mustHaveSelection = true
    }
    
    func initialConfiguration() {
        loadData() //refer code below, from extension onwards
        connectTableViewToService()
        setupPaypalConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goldMembershipInfo(_ sender: Any) {
        showAlert(alertMessage: (self.memInfoResponseData["membership_levels"]![0]["description"].stringValue), type: "justified")
    }
    
    @IBAction func bronzeMembershipInfo(_ sender: Any) {
        showAlert(alertMessage: (self.memInfoResponseData["membership_levels"]![1]["description"].stringValue), type: "justified")
    }
    
    @IBAction func updateMembership(_ sender: Any) {
       
        let condition1 = (self.currentMembership == "Gold" && self.goldOption.on == true)
        
        let condition2 = (self.currentMembership == "Bronze" && self.bronzeOption.on == true)
        
        guard condition1 == false else {
            showAlert(alertMessage: "You already have gold membership", type: "centered")
            return
        }
        
        guard condition2 == false else {
            showAlert(alertMessage: "You already have bronze membership", type: "centered")
            return
        }
        
        if(self.currentMembership == "Gold" && self.bronzeOption.on == true) {
            processMembershipDowngrade()
        } else if(self.currentMembership == "Bronze" && self.goldOption.on == true) {
            processMembershipUpgrade()
            //redirectToPayPalView()
            
        }
        
    }
    
    func showAlert(alertMessage: String, type: String) {
        
        switch(type) {
            case "justified" :
                self.present(infoAlert.justifiedTextAlert(alertMessage), animated: true)
                return
            case "centered" :
                self.present(infoAlert.centeredTextAlert(alertMessage), animated: true)
                return
            case "normal" :
                self.present(infoAlert.normalAlert(alertMessage), animated: true)
                return
            default:
                return
        }
    }

}

//Membership Management Logic
extension MemHisViewController {
    
    func initializePostParameters() {
        if UserDefaults.standard.string(forKey: "member_id") != nil {
            memPostParameters["member_id"] = UserDefaults.standard.string(forKey: "member_id")!
        } else {
            memPostParameters["member_id"] = nil
        }
    }
    
    func loadMembershipHistory() {
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/history", postParameters: memPostParameters) { (response) in
            
            guard response["status"] != "error" else {
                self.showAlert(alertMessage: "Internal Error: \(response)", type: "centered")
                self.checkBoxGroup.selectedCheckBox = self.bronzeOption
                return
            }
            self.memHistResponseData = response
            self.memHistTableView.reloadData()
            self.myDispatchGroup.leave()
        }
    }
    
    func loadMemberMembershipInfo() {
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership", postParameters: memPostParameters) { (response) in
            guard response["status"] != "error" else {
                self.showAlert(alertMessage: "Internal Error: \(response)", type: "centered")
                return
            }
            
            guard response["membership"] != nil else {
                self.showAlert(alertMessage:"Please check your internet connection", type: "centered")
                return
            }
            
            if response["membership"]!["membership_level_name"] == "Gold" {
                self.initialCheckBoxSelected = self.goldOption
                self.currentMembership = response["membership"]!["membership_level_name"].stringValue
            } else {
                self.initialCheckBoxSelected = self.bronzeOption
                self.currentMembership = response["membership"]!["membership_level_name"].stringValue
            }
            self.myDispatchGroup.leave()
        }
    }
    
    func loadMembershipHelpInfo() {
        myDispatchGroup.enter()
        apiHandler.getRequest(apiParameters: "membership/levels") { (response) in
            
            guard response["status"] != "error" else {
                self.showAlert(alertMessage: "Internal Error: \(response)", type: "centered")
                return
            }
            
            guard response["membership_levels"] != nil else {
                self.showAlert(alertMessage: "Please check your internet connection", type: "centered")
                return
            }
            
            var stringBlockForLabel:[String] = []
            var stringBlocks:String = ""
            
            for stringBlock in (response["membership_levels"]?.arrayValue)! {
                stringBlocks.append(stringBlock["name"].stringValue)
                stringBlocks.append(": ")
                stringBlocks.append(stringBlock["duration_amount"].stringValue)
                
                if(stringBlock["duration_type"] == "3") {
                    stringBlocks.append(" months")
                } else {
                    stringBlocks.append(" years")
                }
                
                if(stringBlock["price"].stringValue == "0.00") {
                    stringBlocks.append(" : FREE")
                } else {
                    stringBlocks.append("  - ")
                    stringBlocks.append(stringBlock["price"].stringValue)
                    stringBlocks.append("AUD")
                }
                
                stringBlockForLabel.append(stringBlocks)
                stringBlocks.removeAll()
            }
            self.memInfoResponseData = response
            self.goldMemInfo.text = stringBlockForLabel[0]
            self.bronzeMemInfo.text = stringBlockForLabel[1]
            self.myDispatchGroup.leave()
        }
        
    }
    
    func loadData() {
        
        initializePostParameters()
        
        guard self.memPostParameters["member_id"] != nil else {
            showAlert(alertMessage: "Cannot display membership, \n please sign in or sign up", type: "centered")
            selectButton.isUserInteractionEnabled = false
            return
        }
        
        guard self.memPostParameters["member_id"]?.isEmpty == false else {
            showAlert(alertMessage: "Cannot display membership, \n please sign in or sign up", type: "centered")
            selectButton.isUserInteractionEnabled = false
            return
        }
        
        loadMembershipHistory()
        loadMemberMembershipInfo()
        loadMembershipHelpInfo()
        
        myDispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests.")
            self.configureCheckBoxGroup(checkBoxSelected: self.initialCheckBoxSelected)
        })
        
    }
    
    func processMembershipUpgrade() {
        memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![0]["id"].stringValue
        memPostParameters["nonce"] = ""
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/update", postParameters: memPostParameters) { (response) in
            self.myDispatchGroup.leave()
        }
        myDispatchGroup.notify(queue: DispatchQueue.main) {
            self.showAlert(alertMessage: "Your membership has been upgraded", type: "centered")
            self.currentMembership = "Gold"
            UserDefaults.standard.set(self.memInfoResponseData["membership_levels"]![0]["id"].stringValue, forKey: "membership_level_id")
            UserDefaults.standard.synchronize()
        }
    }
    
    func processMembershipDowngrade() {
        memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![1]["id"].stringValue
        memPostParameters["nonce"] = ""
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/update", postParameters: memPostParameters) { (response) in
            self.myDispatchGroup.leave()
        }
        myDispatchGroup.notify(queue: DispatchQueue.main) {
            self.showAlert(alertMessage: "Your membership has been downgraded", type: "centered")
            self.currentMembership = "Bronze"
            UserDefaults.standard.set(self.memInfoResponseData["membership_levels"]![1]["id"].stringValue, forKey: "membership_level_id")
            UserDefaults.standard.synchronize()
        }
    }
}

//Paypal integration code.
extension MemHisViewController : PayPalPaymentDelegate {
    
    func redirectToPayPalView() {
        let shipping = NSDecimalNumber(string:"0.00")
        let tax = NSDecimalNumber(string:"0.00")
        let subtotal = NSDecimalNumber(string: self.memInfoResponseData["membership_levels"]![0]["price"].stringValue)
        // let subtotal = NSDecimalNumber(string: "0.10") //test amount as current gold membership is set to 0.00 AUD
        
        
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total,
                                    currencyCode: "AUD",
                                    shortDescription: "On The House: Gold Membership Upgrade",
                                    intent: .sale)
        
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self)
            self.present(paymentViewController!, animated: true, completion: nil)
            
        } else {
            showAlert(alertMessage: "Internal Error: Payment amount \(total) cannot be processed.", type: "centered")
        }

    }
    
    func setupPaypalConfiguration() {
        
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "On-The-House, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .both
        
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paypalTransactionSuccessful = false
        paymentViewController.dismiss(animated: true, completion: nil)
        self.present(infoAlert.normalAlert("Payment was not processed. Your membership has not been upgraded."), animated: true)
        
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            self.showAlert(alertMessage: "\(completedPayment.confirmation) has been successfully processed", type: "normal")
            self.paypalTransactionSuccessful = true
            self.performSegue(withIdentifier: "finish1", sender: self)
        })
    }
    
    
}
