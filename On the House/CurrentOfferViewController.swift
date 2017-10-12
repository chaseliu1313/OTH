//
//  CurrentOfferViewController.swift
//  On the House
//
//  Created by Chase on 11/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class CurrentOfferViewController: UIViewController {

    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var tickets: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    var eventID = ""
    var showID = ""
    var eventName = ""
    var ticketsNum = ""
    var date = ""
    var venueID = ""
    
    
    var loadRatings: [[String:String]] = [[:]]
    @IBOutlet weak var ratings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getVenue()
        getRatings()
        self.Name.text = eventName
        self.tickets.text = "Date: \(date) \n Tickets Reserved: \(ticketsNum)"
        ratings.delegate = self
        ratings.dataSource = self
        ratings.backgroundColor = UIColor.clear
        ratings.reloadData()
    }
    
    

    @IBOutlet weak var `return`: UIButton!
    
    @IBAction func returnN(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func getVenue(){
        
        let command = "api/v1/venue/\(self.venueID)"
        ConnectionHelper.getJSON(command: command) { (success, json) in
            if success {
                
                if let name = json["venue"]["name"].string,
                    let add1 = json["venue"]["address1"].string,
                    let add2 = json["venue"]["address2"].string,
                    let city = json["venue"]["city"].string,
                    let zone = json["venue"]["zone_name"].string,
                    let zip = json["venue"]["zip"].string {
                    
                    self.venue.text = "\(name)\n\(add1), \(add2)\n\(city) \(zip) \(zone) Australia"
                    
                }
                
            }
            else {
                
                print("venue loading error")
                
            }
        }
        
        
    }
    func getRatings(){
        
        let command = "api/v1/event/ratings"
        let parameter = ["event_id": self.eventID]
        
        ConnectionHelper.postJSON(command: command, parameter: parameter) { (success, json) in
        
            if success
            {
                self.loadRatings = json["ratings"].arrayObject as! [[String:String]]
                
                
            }
        }
        
    }
}

extension CurrentOfferViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loadRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "allratingCell", for: indexPath) as! AllRatingTabTableViewCell
        
        if self.loadRatings.count == 0 {
            cell.comment.text = "No one from ON THE HOUSE has rated this."
            cell.name.text = " "
            
        }
        else {
            
            let userComment = self.loadRatings[indexPath.row]
            
            if let fileName = userComment["rating"], let name = userComment["member_nickname"],let comment = userComment["comment"]{
                print("cell stars")
                print(fileName)
                cell.starts.image = UIImage(named: fileName)
                cell.name.text = name
                cell.comment.text = comment
            }
            
            
            
        }
        
        
        cell.backgroundColor = UIColor.clear
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107.0
    }
    
    
    
    
    
    
    
    
    
}
