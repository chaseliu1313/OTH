//
//  ViewController.swift
//  AlamofireSwiftyJSONTest2
//
//  Created by Client on 15/9/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import BEMCheckBox

class MHUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var goldMembershipLabel: UILabel!
    @IBOutlet weak var bronzeMembershipLabel: UILabel!

    @IBOutlet weak var GoldOptions: BEMCheckBox!
    @IBOutlet weak var BronzeOptions: BEMCheckBox!
    
    var currentMembership:String = ""

    var group = BEMCheckBoxGroup()
    
    @IBOutlet weak var membershipHistoryTableView: UITableView!
    
    var listData:JSON = []
    
    let apiHandler = APIHandler()
    
    let memberID:Parameters = [
        "member_id":"56"
    ]
    
    @IBAction func moreInfoOnGold(_ sender: Any) {
        apiHandler.extractGetResponse(apiParameters: "membership/levels") { (responseObject) in
            
            self.notifyUser("Gold Membership", responseObject["membership_levels"]![0]["description"].stringValue)
        }
    }
    
    @IBAction func moreInfoOnBronze(_ sender: Any) {
        apiHandler.extractGetResponse(apiParameters: "membership/levels") { (responseObject) in
            
            self.notifyUser("Bronze Membership", responseObject["membership_levels"]![1]["description"].stringValue)
        }
    }
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
    
        self.membershipHistoryTableView.delegate = self
        self.membershipHistoryTableView.dataSource = self
        
        
        let url:String = "https://ma.on-the-house.org/api/v1/member/membership/history"
        
        //Membership History POST request
        Alamofire.request(url, method: .post, parameters: memberID).responseJSON { (response) in
            switch response.result {
            case .success:
                self.listData = JSON(response.result.value!)
                self.membershipHistoryTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

        //extracting membership information as per the website.
        apiHandler.extractGetResponse(apiParameters: "membership/levels") { (responseObject) in

            var stringBlockForLabel:[String] = []
            var stringBlocks:String = ""
    
            for stringBlock in (responseObject["membership_levels"]?.arrayValue)! {
                stringBlocks.append(stringBlock["name"].stringValue)
                stringBlocks.append(": ")
                stringBlocks.append(stringBlock["duration_amount"].stringValue)
                if(stringBlock["duration_type"] == "3") {
                    stringBlocks.append(" months")
                } else {
                    stringBlocks.append(" years")
                }
                if(stringBlock["price"].stringValue == "0.00") {
                    stringBlocks.append("          : FREE")
                } else {
                    stringBlocks.append("  - ")
                    stringBlocks.append(stringBlock["price"].stringValue)
                    stringBlocks.append("AUD")
                }
                stringBlockForLabel.append(stringBlocks)
                stringBlocks.removeAll()
            }
            
            self.goldMembershipLabel.text = stringBlockForLabel[0]
            self.bronzeMembershipLabel.text = stringBlockForLabel[1]
        
         }
        
        //extracting current membership information.
        apiHandler.extractPostResponse(apiParameters: "member/membership", postParameters: memberID) { (responseObject) in
            if responseObject["membership"]!["membership_level_name"] == "Gold" {
                self.configureCheckBoxGroup(checkBoxSelected: self.GoldOptions)
                self.currentMembership = "Gold"
            } else {
                self.configureCheckBoxGroup(checkBoxSelected: self.BronzeOptions)
                self.currentMembership = "Bronze"
            }
        }

    }
    
    func configureCheckBoxGroup(checkBoxSelected: BEMCheckBox) {
        
        self.group.addCheckBox(toGroup: GoldOptions)
        self.group.addCheckBox(toGroup: BronzeOptions)
        
        self.group.selectedCheckBox = checkBoxSelected
        self.group.mustHaveSelection = true

        self.GoldOptions.onAnimationType = BEMAnimationType.stroke
        self.GoldOptions.offAnimationType = BEMAnimationType.stroke
        
        self.BronzeOptions.onAnimationType = BEMAnimationType.stroke
        self.BronzeOptions.offAnimationType = BEMAnimationType.stroke
    
    }
    
    @IBAction func changeMembership(_ sender: Any) {
        if(self.currentMembership == "Bronze" && self.GoldOptions.on){
            notifyUser("On The House", "Redirecting to Paypal - [WIP]")
            self.currentMembership = "Gold"
        } else if(self.currentMembership == "Gold" && self.BronzeOptions.on) {
            notifyUser("On The House", "Cannot perform this operation before the Gold membership expiry date")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData["memberships"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membershipHistoryTableView.dequeueReusableCell(withIdentifier: "membershipHistoryCell", for: indexPath) as? MHTableViewCell
        
        cell?.membershipLevel.text = listData["memberships"][indexPath.row]["membership_level_name"].stringValue
        cell?.membershipPrice.text = "$" + listData["memberships"][indexPath.row]["price"].stringValue

        let formatDate = DateUtility()
        let startDate:String = formatDate.getFormattedDate(dateToConvert: listData["memberships"][indexPath.row]["date_created"].doubleValue, format: "dd/MM/YYYY")
        let endDate:String = formatDate.getFormattedDate(dateToConvert: listData["memberships"][indexPath.row]["date_expires"].doubleValue, format: "dd/MM/YYYY")
        
        cell?.membershipPeriod.text = startDate + " - " + endDate
        
        return cell!
    }
    
    //Attributed Notification
    func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName: UIFont.systemFont(ofSize: 13.0)
            ]
        )
        
        alert.setValue(messageText, forKey: "attributedMessage")
        self.present(alert, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

