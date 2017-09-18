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


    @IBOutlet weak var offerVideo: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "pg_zfIDoKSw")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getVideo(videoCode: String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        offerVideo.loadRequest(URLRequest(url:url!))
        
    }

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
