//
//  OfferTableCell.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/6.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import Foundation

class OfferTableCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    @IBOutlet weak var shareEvent: UIButton!
    
    var offer = Offer()
    
    var baseURL = "https://ma.on-the-house.org/events/"
    
    //delegate
    var sendOfferID : sendOfferIDDelegate!

    
    var size = CGSize()
    
    func getsize() -> CGRect{
    
      self.size  = self.eventImage.intrinsicContentSize
        
        
        
        return self.eventImage.frame
    }
    
    var didSkip: Bool = false
    
    //sharing button
    @IBAction func share(_ sender: UIButton) {
        let eventID = Offers.offerload[shareEvent.tag].id
        let sharingURL = baseURL + eventID
        sendOfferID.sendID(offerID: sharingURL)
        
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func changeButton(){
        
        let skip = UserDefaults.standard.bool(forKey: "didSkip")
        
        if skip == true{
            didSkip = true
            checkoutButton.setTitle("Register/Login", for: .normal)
            
            
        }else if self.offer.membership_levels.contains("Bronze"){
        
         // checkoutButton.setTitle("Upgrade to gold", for: .normal)
            checkoutButton.setTitle("Check Out", for: .normal)
            didSkip = false
        
        }
       
            
        else {
            
            
            checkoutButton.setTitle("Check Out", for: .normal)
            didSkip = false
            
            
            
        }}
        
    
}

protocol sendOfferIDDelegate {
    func sendID (offerID: String)
}
