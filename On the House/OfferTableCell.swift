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
    
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    @IBOutlet weak var shareEvent: UIButton!
    
    var offer = Offer()
    
    
    
    
    
    var size = CGSize()
    
    func getsize() -> CGRect{
    
      self.size  = self.eventImage.intrinsicContentSize
        
        
        
        return self.eventImage.frame
    }
    
    var didSkip: Bool = false
    
//    var offer : Offer?{
//        didSet{
//            updateUI()
//        }
//    }
    
//    func updateUI()  {
//        eventTitle.text = offer?.page_title
//        
//        if let profileImageURL = offer?.image_url{
//            if let url = NSURL(string : profileImageURL){
//                if let imagedata = NSData(contentsOf : url as URL) {
//                    eventImage.image = UIImage(data:imagedata as Data)
//                }
//            }
//        }
//        else{
//            eventImage.image = nil
//        }
//    }
    
    
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
            
            
        }else if UserDefaults.standard.string(forKey: "membership_level_id") == "3"
            && !self.offer.membership_levels.contains("Bronze"){
        
          checkoutButton.setTitle("Upgrade to gold", for: .normal)
        
        }
            
            
            
            
        else {
            
            didSkip = false
            
            
            
        }}
        
        

}
