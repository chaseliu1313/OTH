//
//  OfferDeatil.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/13.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import Social
class OfferDeatil: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shows: [Show] = []
    var isProduct: Bool = false
    var OfferID : String = ""
    var offerDetail : Offer?
    var baseURL = "https://ma.on-the-house.org/events/"
    
    var parameter = ["member_id": ""]
    var command = "api/v1/event/"
    
    var passData: [String: String] = [:]
    
    
    //verification vars
    var is_competition = false
    var sold_out = false
    
    var competitionQuestion = ""
    
    
    @IBOutlet weak var adminFee: UILabel!
    
    
    @IBOutlet weak var ourPrice: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var offerDes: UITextView!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var membershipLevel: UILabel!
    @IBOutlet weak var fullPrice: UILabel!

    
    var loadMoreView: UIView?
    
    
    
    @IBOutlet weak var showStatus: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(OfferID)
        offerDes.backgroundColor = UIColor.clear
        self.getDetail()
        showStatus.delegate = self
        showStatus.dataSource = self
        self.loadShowDetail()
        self.showStatus.reloadData()
        self.showStatus.tableFooterView = self.loadMoreView
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
       
       
        
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! ShowTime
        cell.sendInfo = self
        
        if self.isProduct {
            
        cell.show = self.shows[indexPath.row]
            
            
                
                if (cell.show?.is_admin_fee)!  {
                    
                    self.adminFee.text = "Admin Fee: 10"
                    
                }
                else {
                    
                    self.adminFee.text = "Admin Fee: 0"
                    
                }
                
                let title = String(describing: cell.show!.button_text!)
            
                
                cell.bookNow.setTitle(title, for: .normal)
                let time = String(describing: cell.show!.date_formatted!)
                cell.time.text = time
            

        }
            
        else {
            
           cell.show = Offers.showandvenue.shows[indexPath.row]
            
        
            cell.isCompetition = self.offerDetail!.is_competition
        
            
        if cell.show != nil {
        
            
            if (cell.show?.is_admin_fee)!  {
            
                self.adminFee.text = "Admin Fee: $10"
            
            }
            else {
            
            self.adminFee.text = "Admin Fee: $0"
                
            }
            
            let title = String(describing: cell.show!.button_text!)
            
            cell.bookNow.setTitle(title, for: .normal)
            let time = String(describing: cell.show!.date_formatted!)
            cell.time.text = time
            
            if let venueID = cell.show?.venue_id {
                
                let command = "api/v1/venue/\(venueID)"
                
                ConnectionHelper.getJSON(command: command, completion: { (success, json) in
                    
                    if success {
                        
                        if let name = json["venue"]["name"].string,
                        let address1 = json["venue"]["address1"].string,
                        let address2 = json["venue"]["address2"].string,
                        let city = json["venue"]["city"].string,
                            let state = json["venue"]["zone_name"].string, let zip = json["venue"]["zip"].string{
                            
                            cell.venue.text = "Venue: \(name) \(address1), \(address2), \(city), \(state) \(zip)"
                            
                        }
                        
                        
                    }
                })
  
            }
           
            if let max = cell.show?.max_tickets_per_member, let canChoose = cell.show?.member_can_choose {
                cell.limit.textColor = UIColor.red
                
                if canChoose {
                    cell.bottomlimit = 0
                    cell.uplimit = Int(max)!
                    cell.limit.text = "* Choose UP TO \(max) tickets"
                }
                else {
                    
                    cell.uplimit = Int(max)!
                    cell.bottomlimit = cell.uplimit+1
                    cell.limit.text = "* Reserve ONLY \(max) tickets"
                    
                }
                
            }
            if let soldOut = cell.show?.sold_out {
                cell.isSoldOut = soldOut
               
                if soldOut {
                    
                    
                    cell.bookNow.setTitle("Sold Out", for: .normal)
                }
                
            }
        }
        }
        if self.competitionQuestion != "" {
        
        cell.ticketNumber.isHidden = true
         cell.bookNow.setTitle("Enter Now", for: .normal)
            
        }
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if self.isProduct {
        
        return self.shows.count
        }
        else{
        return  Offers.showandvenue.shows.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }

    
    @IBAction func shareEvent(_ sender: Any) {
        
        let url = self.baseURL+OfferID
        
        let image = self.offerDetail?.image
        
        //Alert
        let alert = UIAlertController(title: "Share", message:"Share Event today!", preferredStyle: .actionSheet)
        
        //First action
        let action = UIAlertAction(title: "Share on Facebook", style: .default)
        {(action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                post?.setInitialText("Check out this amazing event!" + url)
                post?.add(image)
                
                self.present(post!, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(service: "Facebook")
            }
        }
        //Second action
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Third action
        let actionThree = UIAlertAction(title: "Share on Twitter", style: .default)
        {(action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                post?.setInitialText("Check out this amazing event!" + url)
                post?.add(image)
                
                self.present(post!, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(service: "Twitter")
            }
        }
        
        //Add action to action sheet
        alert.addAction(actionThree)
        
        alert.addAction(action)
        
        alert.addAction(actionTwo)
        //Present alert
        self.present(alert, animated: true, completion:nil)
        
    }
    
    
    
    
    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
    }


  

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadShowDetail(){
        
        var snv :[[String: Any]] = []
        let url = command + OfferID
        
        
      
        ConnectionHelper.postJSON(command: url, parameter: parameter) { (success, json) in
            if success {
                
                snv = json["event"]["show_data"].arrayObject as! [[String : Any]]
                
                print(json)
               
                if json["event"]["is_product"].bool! {
                    
                    self.isProduct = true
                
                    let data:[[String:Any]] = json["event"]["show_data"][0]["shows"].arrayObject as! [[String : Any]]
                    
                    
                    
                    
                    for d in data {
                    
                    let show = Show(data: d)
                        self.shows.append(show)
                        
                      //print(show.button_text!)
                    }

                
                }
                
                else {
                    
                    if json["event"]["is_competition"].bool! {
                        
                        self.competitionQuestion = json["event"]["competition"]["question"].string!
                    
                        
                    }
                    
                let fp = json["event"]["full_price_string"].string
                let op = json["event"]["our_price_string"].string
                

                if fp != "" {
                
                    self.fullPrice.text = fp!
                    self.ourPrice.text = "Our Price: " + op!
                  
                    
                
                }
                
                let data : [String: Any] = snv[0]
                
                Offers.showandvenue  = ShowAndVenue(data: data)
                
                

                }
                
                
                
                
                self.showStatus.reloadData()
                
            }
            else{
                
              print("did not reload")
            }
        }
    
    
    }
    func updateMemberID(){
    
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
        
        parameter.updateValue(UserDefaults.standard.string(forKey: "member_id")!, forKey: "member_id")
            
        }
        
    }
    
    func getDetail(){
    
    self.offerDetail =  Offers.getOffer(offerID: self.OfferID)
        
        offerDes.text = self.offerDetail!.description
        image.image = self.offerDetail!.image
        nameLabel.text  = self.offerDetail!.name
        
       let fileName = String(self.offerDetail!.rating)
        rating.image = UIImage(named: fileName)
        self.membershipLevel.text = self.offerDetail!.membership_levels
        
        
    }
    
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is Survey    {
        
            let vc = segue.destination as? Survey
            vc?.data = self.passData
        }
        
        else if segue.destination is shipInfoViewController {
        
            let vc = segue.destination as? shipInfoViewController
            vc?.data = self.passData
        }
    }
    

}

extension OfferDeatil: sendBookingInfoProtocol {

    func sendInfo(qty: String, error: String, isCom: Bool, show_id: String, shipping: Bool) {
       
        print(isCom)
        let member_id = UserDefaults.standard.string(forKey: "member_id")!
        let event_id = self.OfferID
        
        
        let name = Notification.Name(rawValue: competitionNotificationKey)
        
       
        
        var data: [String: String] = ["member_id": member_id, "event_id": event_id,"show_id": show_id, "qty": qty]
        self.passData = data
        
        NotificationCenter.default.post(name: name, object: nil, userInfo: data)
        if error != "" {
        
        self.notifyUser([error])
            
        }
        else{
            
           
            
            
            if isCom {
                
                data.updateValue(self.competitionQuestion, forKey: "show_id")
            
            self.performSegue(withIdentifier: "competition", sender: self)
                
                
                
                NotificationCenter.default.post(name: name, object: nil, userInfo: data)
               
                
            }
        
            else{
            
                if shipping{
                
                    self.performSegue(withIdentifier: "withShipping", sender: self)
                    
                    
                
                }
                
                else{
                
                 self.performSegue(withIdentifier: "survey", sender: self)
                     
                    
                    
                }
                
            
            }
        
        }
        
    }

}



  
