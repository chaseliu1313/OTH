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
        print(self.member_id)
        print(self.event_id)
        print(qty)
        print(showID)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateValue(notification:)), name: key, object: nil)
    
    }

}

