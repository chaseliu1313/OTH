//
//  OfferingHomePage.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/6.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import SwiftyJSON

class OfferingHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var offers : [String : Offer]!
    
//    var event = [#imageLiteral(resourceName: "event1.jpg"), #imageLiteral(resourceName: "event2.jpg"), #imageLiteral(resourceName: "event3.jpg")]
//    var evntLable = ["Call Me", "Today", "Just Do It"]
    var loadMoreEnable = true
    var loadMoreView:UIView?
    var offerLoad : [Offer] = []
    //var didSkip: Bool = false
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        self.tableView.tableFooterView = self.loadMoreView
        
        
        sideMenus()
        self.loadOffers()
//        print(offerLoad)
       
        
        
    }
    
    

    
    @IBAction func Share(_ sender: UIButton) {
    
    
    }
    
    
    
    let command = "api/v1/events/current"
    
    var parameter : [String: Any] =
        [
            "date" : "range",
            "date_from" : "2015-05-05",
            "data_to" : "2017-09-11",
            "category_id" : ["37","5"],
            "zone_id" : ["216"]
            
            
            
    ]
    
    
    
    
   
    
    //download offers from the server and ini into Offer objects, then add them to offerLoad array
    func loadOffers()
        
    {
        ConnectionHelper.postJSON(command: command, parameter: parameter) { (success, json) in
            
            if success {
                
                let status = json["status"].string!
                
                print(status)
                
                let event  = json["events"].arrayValue
                
                for e in event {
                    
                    
                    let v = e.dictionaryObject!
                    let o : Offer = Offer.init(data: v)
                   
                    self.offerLoad.append(o)
                    
                    
                }
                
                print(self.offerLoad.count)
                print(self.offerLoad[0].description!)
                
               self.tableView.reloadData()
                
            }
            else {
                
                print("post is wrong")
            }
        }
        
    }
    
    
    func refreshOffer(){
//        event.append(#imageLiteral(resourceName: "event4.jpg"))
//        event.append(#imageLiteral(resourceName: "event5.jpg"))
//        event.append(#imageLiteral(resourceName: "event6.jpg"))
//        evntLable.append("Let's dance")
//        evntLable.append("Come")
//        evntLable.append("See you again")
        
        loadOffers()
        
        tableView.reloadData()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (offerLoad.count)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop"
        {
            let dest = segue.destination
            if let pop = dest.popoverPresentationController
            {
                pop.delegate = self
            }
        }
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    func sideMenus(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 200
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"eventCell", for: indexPath) as! OfferTableCell
        
        let offer = offerLoad[indexPath.row]
        cell.eventTitle.text = offer.name
         offer.insert()
       cell.imageView?.image =  offer.getImage()
        
   
        
       
        
       

        
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        if (loadMoreEnable && indexPath.row == offerLoad.count-1) {
            refreshOffer()
        }
        return cell
        
        
        //        if let offercell = cell as? OfferTableCell{
        //            offercell.offer = offer
        //        }
        //cell.eventImage.image = UIImage
        
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
