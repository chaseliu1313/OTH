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
    
    func loadMembershipInfoData() {
        
        if UserDefaults.standard.string(forKey: "member_id") != nil {
            memPostParameters["member_id"] = UserDefaults.standard.string(forKey: "member_id")!
        } else {
            memPostParameters["member_id"] = nil
        }
        
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
        
      
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/history", postParameters: memPostParameters) { (response) in
            
            guard response["status"] != "error" else {
                self.showAlert(alertMessage: "Internal Error: \(response)", type: "centered")
                return
            }
            self.memHistResponseData = response
            self.memHistTableView.reloadData()
            self.myDispatchGroup.leave()
        }
        
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
        
        myDispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests.")
            self.configureCheckBoxGroup(checkBoxSelected: self.initialCheckBoxSelected)
        })

    }
    
    func initialConfiguration() {
        loadMembershipInfoData()
        connectTableViewToService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialConfiguration()
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
            return
        }
        
        guard condition2 == false else {
            return
        }
        
        if(self.currentMembership == "Gold" && self.bronzeOption.on == true) {
        
           
            processMembershipDowngrade()
//            myDispatchGroup.enter()
//            memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![0]["id"].stringValue
//            memPostParameters["nonce"] = ""
//            apiHandler.postRequest(apiParameters: "/api/v1/member/membership/update", postParameters: memPostParameters, completionHandler: { (response) in
//                self.myDispatchGroup.leave()
//            })
//
//            myDispatchGroup.notify(queue: DispatchQueue.main, execute: {
//                self.showAlert(alertMessage: "Your will be downgraded to bronze membership after your current membership expires", type: "centered")
//            })
            
        } else if(self.currentMembership == "Bronze" && self.goldOption.on == true) {
            
            showAlert(
                alertMessage: "Redirecting to Paypal",
                type: "centered")
            
            processMembershipUpgrade()
//
//            myDispatchGroup.enter()
//
//            memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![1]["id"].stringValue
//            memPostParameters["nonce"] = ""
//
//            apiHandler.postRequest(apiParameters: "/api/v1/member/membership/update", postParameters: memPostParameters, completionHandler: { (response) in
//                self.myDispatchGroup.leave()
//            })
//
//            myDispatchGroup.notify(queue: DispatchQueue.main, execute: {
//                self.showAlert(alertMessage: "You have been upgraded", type: "centered")
//            })
        
        }
        
    }
    
    private func processMembershipUpgrade() {
        memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![0]["id"].stringValue
        memPostParameters["nonce"] = ""
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/update", postParameters: memPostParameters) { (response) in
            print(response)
            self.myDispatchGroup.leave()
        }
        myDispatchGroup.notify(queue: DispatchQueue.main) {
            self.showAlert(alertMessage: "Your membership has been upgraded", type: "centered")
        }
    }
    
    private func processMembershipDowngrade() {
        memPostParameters["membership_level_id"] = self.memInfoResponseData["membership_levels"]![1]["id"].stringValue
        memPostParameters["nonce"] = ""
        myDispatchGroup.enter()
        apiHandler.postRequest(apiParameters: "member/membership/update", postParameters: memPostParameters) { (response) in
            print(response)
            self.myDispatchGroup.leave()
        }
        myDispatchGroup.notify(queue: DispatchQueue.main) {
            self.showAlert(alertMessage: "Your membership has been downgraded", type: "centered")
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
