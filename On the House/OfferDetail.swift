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
    
    
    
    //verification vars
    var is_competition = false
    var sold_out = false
    
    
    
    
    @IBOutlet weak var adminFee: UILabel!
    
    
    @IBOutlet weak var ourPrice: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var offerDes: UITextView!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var membershipLevel: UILabel!
    @IBOutlet weak var fullPrice: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var state: UILabel!
    var loadMoreView: UIView?
    
    @IBOutlet weak var showStatus: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(OfferID)
        offerDes.backgroundColor = UIColor.clear
        self.getDetail()
        showStatus.delegate = self
        showStatus.dataSource = self
        self.loadShowDetail()
        self.showStatus.reloadData()
        self.showStatus.tableFooterView = self.loadMoreView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! ShowTime
        
        if self.isProduct {
        cell.show = self.shows[indexPath.row]
            
            
                
                if (cell.show?.is_admin_fee)!  {
                    
                    self.adminFee.text = "Admin Fee: 10"
                    
                }
                else {
                    
                    self.adminFee.text = "Admin Fee: 0"
                    
                }
                
                let title = String(describing: cell.show!.button_text!)
                print(title)
                
                cell.bookNow.setTitle(title, for: .normal)
                let time = String(describing: cell.show!.date_formatted!)
                cell.time.text = time
            

        }
        else {
            
            cell.show = Offers.showandvenue.shows[indexPath.row]}
            cell.isCompetition = self.offerDetail!.is_competition
        
        if cell.show != nil {
        
            if (cell.show?.is_admin_fee)!  {
            
                self.adminFee.text = "Admin Fee: 10"
            
            }
            else {
            
            self.adminFee.text = "Admin Fee: 0"
                
            }
            
            let title = String(describing: cell.show!.button_text!)
            print(title)
            
            cell.bookNow.setTitle(title, for: .normal)
            let time = String(describing: cell.show!.date_formatted!)
            cell.time.text = time
        }
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.sendInfo = self
       
        
        
        
        
        
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
        
        
        //let url = command + OfferID
        ConnectionHelper.postJSON(command: url, parameter: parameter) { (success, json) in
            if success {
                snv = json["event"]["show_data"].arrayObject as! [[String : Any]]
                
                if json["event"]["is_product"].bool! {
                    
                    self.isProduct = true
                
                    let data:[[String:Any]] = json["event"]["show_data"][0]["shows"].arrayObject as! [[String : Any]]
                    
                    
                    
                    
                    for d in data {
                    
                    let show = Show(data: d)
                        self.shows.append(show)
                        
                      print(show.button_text!)
                    }

                
                }
                
                else {
                let fp = json["event"]["full_price_string"].string
                let op = json["event"]["our_price_string"].string
                

                if fp != "" {
                
                    self.fullPrice.text = fp!
                    self.ourPrice.text = "Our Price: " + op!
                  
                    
                
                }
                
                let data : [String: Any] = snv[0]
                
                Offers.showandvenue  = ShowAndVenue(data: data)
                
                
                
                self.address1.text = Offers.showandvenue.venue?.address1
                self.address2.text = Offers.showandvenue.venue?.address2
                self.City.text = Offers.showandvenue.venue?.city
//                self.fullPrice.text = json["event"]["full_price_string"].string
//                self.ourPrice.text = json["event"]["our_price_string"].string
//                
//                self.membershipLevel.text = json["event"]["membership_levels"].string
//                
                let zone = System.getKey(id: Int((Offers.showandvenue.venue?.zone_id)!)!, dic: System.states)
                
                self.state.text = zone}
                
                
                
                
                self.showStatus.reloadData()
                
                print(Offers.showandvenue.shows.count)
            }
            else{
                
//                self.notifyUser(["Loading Error"])
//                self.dismiss(animated: true, completion: nil)
//             
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
    

}

extension OfferDeatil: sendBookingInfoProtocol {

    func sendInfo(qty: String, error: String, isCom: Bool, show_id: String, shipping: Bool) {
       
        let member_id = UserDefaults.standard.string(forKey: "member_id")!
        let event_id = self.OfferID
        let quantity = qty
        let showID = show_id
        
        let name = Notification.Name(rawValue: competitionNotificationKey)
        
        
        let data: [String: String] = ["member_id": member_id, "event_id": event_id]
        
        
        if error != "" {
        
        self.notifyUser([error])
            
        }
        else{
            
           
            
            
            if isCom {
            
            self.performSegue(withIdentifier: "competition", sender: self)
                
                
                
                NotificationCenter.default.post(name: name, object: nil, userInfo: data)
               
                
            }
        
            else{
            
                if shipping{
                
                    self.performSegue(withIdentifier: "withShipping", sender: self)
                    
                     let name = Notification.Name(rawValue: shippingNotificationKey)
                    let data :[String: String] = ["show_id": show_id, "member_id": member_id, "qty": qty]
                    
                    NotificationCenter.default.post(name: name, object: nil, userInfo: data)
                    
                
                }
                
                else{
                
                 self.performSegue(withIdentifier: "survey", sender: self)
                    let name = Notification.Name(rawValue: surveyNotificationKey)
                    let data :[String: String] = ["show_id": showID, "member_id": member_id, "qty": quantity]
                    NotificationCenter.default.post(name: name, object: nil, userInfo: data)
                    
                    
                }
                
            
            }
        
        }
        
    }

}



  
