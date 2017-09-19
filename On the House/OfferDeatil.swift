//
//  OfferDeatil.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/13.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import Social
class OfferDeatil: UIViewController {

    
     var OfferID : String = ""
    var offerDetail : Offer?
     var baseURL = "https://ma.on-the-house.org/events/"
    var parameter = ["member_id": ""]
    var command = "api/v1/event/"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var offerDes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(OfferID)
        offerDes.backgroundColor = UIColor.clear
        self.getDetail()
        
    }

    
    @IBAction func shareEvent(_ sender: Any) {
        //Alert
        let alert = UIAlertController(title: "Share", message:"Share Event today!", preferredStyle: .actionSheet)
        
        //First action
        let action = UIAlertAction(title: "Share on Facebook", style: .default)
        {(action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                post?.setInitialText("Check out this amazing event!")
                
                self.present(post!, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(service: "Facebook")
            }
        }
        //Second action
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Add action to action sheet
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
        
        let url = command + OfferID
        ConnectionHelper.postJSON(command: url, parameter: parameter) { (success, json) in
            if success {
                
                
            }
            else{
            
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
    
    }

}
