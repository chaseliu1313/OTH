//
//  MyOffers.swift
//  On the House
//
//  Created by Geng Xu on 2017/10/2.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class MyOffers: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var currentoffer = ["a","b","c","d","e"]
    var pastoffer = ["a","b","c"]
    var type = true
    
    let command1 = "api/v1/member/reservations"
    let command2 = "api/v1/member/reservations/past"
    var parameter = ["member_id": ""]
    
    
    var reservations :[[String: Any]] = [[:]]
    var reservations2 : [[String: Any]] = [[:]]
    
    
    
    var eventID = ""
    
    @IBOutlet weak var currentOfferTableView: UITableView!
    
    @IBOutlet weak var pastOfferTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let member_id = UserDefaults.standard.string(forKey: "member_id")
        self.parameter.updateValue(member_id!, forKey: "member_id")
        self.loadReservs()
        
    
        
           }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if ( currentOfferTableView == tableView){
            
            print(reservations.count)
               return(reservations.count)
            
        }else {
            
            
                return(reservations2.count)
            
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView == currentOfferTableView{
            
            
       let cell = tableView.dequeueReusableCell(withIdentifier:"currentcell", for: indexPath) as! MyOfferTableViewCell
            cell.showShortcut.text = reservations[indexPath.row]["event_name"] as? String
            cell.dateTime.text = reservations[indexPath.row]["date"] as? String
            cell.qty.text = reservations[indexPath.row]["num_tickets"] as? String
            cell.venue.text = reservations[indexPath.row]["venue_name"] as? String
            
            if let id = reservations[indexPath.row]["event_id"] as? String {
               
                cell.eventID = id
            
            }
            
            
            cell.sendInfo = self
            
            
        return cell
            
            
        }else{
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier:"pastcell", for: indexPath) as! MyPastOfferTableViewCell
            
            cell2.showShortcut.text = reservations2[indexPath.row]["event_name"] as? String
            cell2.dateTime.text = reservations2[indexPath.row]["date"] as? String
            cell2.qty.text = reservations2[indexPath.row]["num_tickets"] as? String
            cell2.venue.text = reservations[indexPath.row]["venue_name"] as? String
            
            if let id = reservations2[indexPath.row]["event_id"] as? String {
            
                
                 cell2.eventID = id
            }
            
          
        
           cell2.sendInfo = self
            return cell2

        }
        

     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.destination is RatingDetailViewController    {
            
            let vc = segue.destination as? RatingDetailViewController
            
            vc?.type = self.type
            vc?.event_id = self.eventID
            
        }
        
    }
    
    func loadReservs(){
    
        
        ConnectionHelper.postJSON(command: command1, parameter: parameter) { (success, json) in
            
            if success {
            
                self.reservations = json["reservations"].arrayObject as![[String: Any]]
                print(self.reservations.count)
                self.currentOfferTableView.reloadData()
            
            }
            
            else {
            print(json)
            
            }
        }
        
        ConnectionHelper.postJSON(command: command2, parameter: parameter) { (success, json) in
            if success {
                
                self.reservations2 = json["reservations"].arrayObject as![[String: Any]]
                self.pastOfferTableView.reloadData()
                
            }
                
            else {
                print(json)
                
            }
        }
        
        
        
        
    }
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MyOffers: sendInfoDelegate {

    func sendInfo(eventID: String, type: Bool) {
        self.eventID = eventID
        self.type = type
        print(self.eventID)
        self.performSegue(withIdentifier: "rate", sender: self)
    }


}
