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
    

    var loadMoreEnable = true
    var loadMoreView: UIView?
    var didSelectRow: Int = 0
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        self.tableView.tableFooterView = self.loadMoreView
        
        
        sideMenus()
        self.loadOffers()
       
        
        
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
    
    
    @IBAction func showDetail(_ sender: Any) {
        
    }
    
    
   
    
    
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
                    o.getImage()
                   
                    Offers.offerload.append(o)
                    
                    //self.offerLoad.append(o)
                    
                    
                }
                
                print(Offers.offerload.count)
                print(Offers.offerload[0].description)
                
               self.tableView.reloadData()
                
            }
            else {
                
                print("post is wrong")
            }
        }
        
    }
    
    
    func refreshOffer(){

        
        loadOffers()
        
        tableView.reloadData()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (Offers.offerload.count)
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
        
        let offer = Offers.offerload[indexPath.row]
        cell.offer = offer
        
        cell.eventTitle.text = offer.name
         offer.insert()
        
        
        
        print(cell.getsize().width)
        let size = CGSize.init(width: cell.getsize().width, height: cell.getsize().height)
        
        let cellImage =  UIImage.scaleImageToSize(img: offer.getImage(), size: size)
        
        cell.imageView?.image = cellImage
       
      

        
        cell.changeButton()
        
        if UserDefaults.standard.string(forKey: "membership_level_id") == "3"
            && !cell.offer.membership_levels.contains("Bronze"){
            
        cell.checkoutButton.addTarget(self, action: #selector(OfferingHomePage.jumpUpgrade), for: .touchUpInside)
            
        }
        else if UserDefaults.standard.bool(forKey: "didSkip") == true {

        cell.checkoutButton.addTarget(self, action: #selector(OfferingHomePage.jumpReg), for: .touchUpInside)
        }
        
        
        
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        if (loadMoreEnable && indexPath.row == Offers.offerload.count-1) {
            refreshOffer()
        }
        return cell
        
        
      
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        didSelectRow = indexPath.row
        print(didSelectRow)
        performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    func jumpReg(){
        self.performSegue(withIdentifier: "jumpReg", sender: self)
    }
    
    func jumpUpgrade(){
        self.performSegue(withIdentifier: "jumpUpgrade", sender: self)
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

extension UIImage {
    
    class func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        img.draw(in: CGRect(origin: CGPoint(x: 0, y:0), size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return scaledImage!
        
    }
    
}
