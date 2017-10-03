//
//  CompetitionViewController.swift
//  On the House
//
//  Created by Chase on 26/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

let competitionNotificationKey = "key.competition"

class CompetitionTickets: UIViewController {

    @IBOutlet weak var answer: UITextField!
    var event_id = ""
    var member_id = ""
    
    var parameter: [String:String] = ["event_id":"", "member_id": "", "competition_answer": ""]
    
    let command = "api/v1/competition/enter"
    
    @IBOutlet weak var questonTest: UILabel!
    @IBOutlet weak var quetionAnswer: UITextField!
    
    let key = Notification.Name(rawValue: competitionNotificationKey)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.createObserver()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func `return`(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func submit(_ sender: Any) {
        
        
        if self.quetionAnswer.text! == "" {
        
        self.notifyUser(["Please enter your answer"])
            return
        }
        
        
        self.parameter.updateValue(self.event_id, forKey: "event_id")
        self.parameter.updateValue(self.member_id, forKey: "member_id")
        self.parameter.updateValue(self.quetionAnswer.text!, forKey: "competition_answer")
       
      ConnectionHelper.postJSON(command: command, parameter: parameter) { (success, json) in
        
        if success {
        
            
            
            self.notifyUser(["You have entered the competition!"])
        
        }
        
        else {
           
        
            self.notifyUser(["You have already entered this competition"])
        }
        }
        
        
    }
    func updateValue(notification: NSNotification) {
    
        guard let memberID = notification.userInfo?["member_id"] as? String
        , let eventID = notification.userInfo?["event_id"] as? String
        , let qty = notification.userInfo?["qty"] as? String
        , let showID = notification.userInfo?["show_id"] as? String
            else
        {
        return
        }
    
        self.member_id = memberID
        self.event_id = eventID
        self.questonTest.text = showID
        print(self.member_id)
        print(self.event_id)
        print(qty)
        print(showID)
        
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateValue(notification:)), name: key, object: nil)
    
    }
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
}

