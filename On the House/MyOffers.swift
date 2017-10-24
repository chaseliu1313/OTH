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
    
    
    //values fro paasing between view controllers
    var eventID = ""
    var showID = ""
    var eventName = ""
    var tickets = ""
    var date = ""
    var venueID = ""
    
    var reservationID = ""
    
    @IBOutlet weak var currentOfferTableView: UITableView!
    
    @IBOutlet weak var pastOfferTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let member_id = UserDefaults.standard.string(forKey: "member_id")
        {self.parameter.updateValue(member_id, forKey: "member_id")}
        
        
        
        self.loadReservs()
        
     
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if ( currentOfferTableView == tableView){
            
            print("table1 \(reservations.count)")
            return(reservations.count)
            
        }else {
            
            print("table2 \(reservations2.count)")
            return(reservations2.count)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == currentOfferTableView{
            print("table1 \(indexPath.row)")
            
            let cell = tableView.dequeueReusableCell(withIdentifier:"currentcell", for: indexPath) as! MyOfferTableViewCell
            cell.showShortcut.text = reservations[indexPath.row]["event_name"] as? String
            cell.dateTime.text = reservations[indexPath.row]["date"] as? String
            cell.qty.text = reservations[indexPath.row]["num_tickets"] as? String
            cell.venue.text = reservations[indexPath.row]["venue_name"] as? String
            
            if let sid = reservations[indexPath.row]["show_id"] as? String {
                
                cell.showID = sid
                
                
            }
            
            
            if let id = reservations[indexPath.row]["event_id"] as? String {
                
                cell.eventID = id
                
            }
            
            if let cancel = reservations[indexPath.row]["can_cancel"] as? Bool {
                
                if !cancel {
                    
                    cell.Cancel.isHidden = true
                }
                else {
                    
                    
                    cell.Cancel.addTarget(self, action: #selector(cancelReservation), for: .touchUpInside)
                }
                
            }
            
            
            if let en = reservations[indexPath.row]["event_name"] as? String,let d = reservations[indexPath.row]["date"] as? String, let r = reservations[indexPath.row]["num_tickets"] as? String, let v = reservations[indexPath.row]["venue_id"] as? String, let reserv = reservations[indexPath.row]["reservation_id"] as? String {
                self.eventName = en
                self.date = d
                self.tickets = r
                self.venueID = v
                self.reservationID = reserv
            }
            
            
            
            
            
            cell.moreInfo.addTarget(self, action: #selector(showCurrentDetail), for: .touchUpInside)
            
            cell.sendInfo = self
            cell.moreInfo.layer.cornerRadius = 8
            
            
            return cell
            
            
        }else{
            print("table1 \(indexPath.row)")
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier:"pastcell", for: indexPath) as! MyPastOfferTableViewCell
            
            cell2.showShortcut.text = reservations2[indexPath.row]["event_name"] as? String
            cell2.dateTime.text = reservations2[indexPath.row]["date"] as? String
            cell2.qty.text = reservations2[indexPath.row]["num_tickets"] as? String
            cell2.venue.text = reservations[indexPath.row]["venue_name"] as? String
            
            cell2.moreInfo.layer.cornerRadius = 8
            
            if let sid = reservations[indexPath.row]["show_id"] as? String, let has_rated = reservations[indexPath.row]["has_rated"] as? Int {
                
                
                
                cell2.showID = sid
                
                if has_rated == 0 {
                    
                    cell2.moreInfo.setTitle("More Info", for: .normal)
                    cell2.type = true
                    
                }
                
                
            }
            
            if let id = reservations2[indexPath.row]["event_id"] as? String {
                
                
                cell2.eventID = id
            }
            
            
            
            cell2.moreInfo.addTarget(self, action: #selector(PastOfferDetail), for: .touchUpInside)
            
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
        else if segue.destination is CurrentOfferViewController {
            let vc = segue.destination as? CurrentOfferViewController
            
            vc?.showID = self.showID
            vc?.eventID = self.eventID
            vc?.eventName = self.eventName
            vc?.ticketsNum = self.tickets
            vc?.date = self.date
            vc?.venueID = self.venueID
        }
        
    }
    
    
    func showCurrentDetail(){
        
        self.performSegue(withIdentifier: "currentOffer", sender: self)
        
    }
    
    func PastOfferDetail() {
        
        self.performSegue(withIdentifier: "rate", sender: self)
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
    
    //cancel reservation
    func cancelReservation(){
        
        let command = "api/v1/reservation/cancel"
        guard let id = UserDefaults.standard.string(forKey: "member_id")
            else {return}
        let parameter = ["reservation_id": self.reservationID, "member_id": id]
        
        ConnectionHelper.postJSON(command: command, parameter: parameter) { (success, json) in
            
            if success {
                
                self.notifyUser(["Your reservation is canceled"])
            }
                
            else {
                if let error = json["error"]["messages"].arrayObject as? [String]
                {
                    self.notifyUser(error)
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    func notifyUser( _ message: [String] ) -> Void
    {
        
        var meg = " "
        for m in message {
            
            meg.append("\(m) \n")
        }
        
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
}

extension MyOffers: sendInfoDelegate {
    
    func sendInfo(eventID: String, type: Bool, showID: String) {
        self.eventID = eventID
        self.type = type
        self.showID = showID
        
        
    }
    
    
}
